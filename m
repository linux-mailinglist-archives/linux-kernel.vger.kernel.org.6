Return-Path: <linux-kernel+bounces-301002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E459595EB73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12E0284729
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44413BAE4;
	Mon, 26 Aug 2024 08:08:53 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCE13AD3F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659733; cv=none; b=KFiHxtX+w2PwEfWpP7GeOg3drTqzbH5a2/SSsvepg1PQkob5ToAfypThbLur/0yIA5ACp8GblECGbCYyJlA4PVLMMPzYNHLxguiveyCFEku/dIdWIAFJBD8j/NgIY+Kma6wTisFuLOL0TCJ8wYTqdUMftSvg7+xmeCL3gsDGta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659733; c=relaxed/simple;
	bh=rSJrgsmfUsElrCODWDV1oJPTLGA/DsgUQ52abwDQqcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SKSkmAq4sNyDc9tEpCH3ivISPafAmv5PUc/vIQFhdBAydL0b0ER9Whh/joY++uCL+nTo37Kft/5khHoTrn6630fzu9iBQS83nCvHuNFNA/JAE1BorZKjVJwrx4mSCU1CoFB0RjCb2XWIwh9qfNFyfR3GxIDcLp7JN/3NXkidUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:344c:fc9f:aaa5:f9d2])
	by albert.telenet-ops.be with cmsmtp
	id 4Y8h2D00N3GuYDE06Y8hia; Mon, 26 Aug 2024 10:08:41 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1siUmH-0011af-He;
	Mon, 26 Aug 2024 10:08:41 +0200
Date: Mon, 26 Aug 2024 10:08:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] dm-integrity: introduce the Inline mode
In-Reply-To: <c994d5e-cc3d-d7f5-ce3-fd2cf91e850@redhat.com>
Message-ID: <512a07c-d41a-27c4-b1f9-8fe19352d1f@linux-m68k.org>
References: <c994d5e-cc3d-d7f5-ce3-fd2cf91e850@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Mikulas,

On Tue, 25 Jun 2024, Mikulas Patocka wrote:
> This commit introduces a new 'I' mode for dm-integrity.
>
> The 'I' mode may be selected if the underlying device has non-power-of-2
> sector size. In this mode, dm-integrity will store integrity data
> directly in device's sectors and it will not use journal.
>
> This mode improves performance and reduces flash wear because there would
> be no journal writes.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Thanks for your patch, which is now commit fb0987682c629c1d
("dm-integrity: introduce the Inline mode") in v6.11-rc1.

> @@ -4433,9 +4737,12 @@ static int dm_integrity_ctr(struct dm_ta
> 		ti->error = "Block size doesn't match the information in superblock";
> 		goto bad;
> 	}
> -	if (!le32_to_cpu(ic->sb->journal_sections)) {
> +	if (!le32_to_cpu(ic->sb->journal_sections) != (ic->mode == 'I')) {

As reporting before in e.g. [1], this is causing build failures with
gcc-5 and -Werror:

     drivers/md/dm-integrity.c:4718:52: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]
       if (!le32_to_cpu(ic->sb->journal_sections) != (ic->mode == 'I')) {
 							^

I could reproduce the issue with gcc-5(Ubuntu 5.5.0-12ubuntu1) on x86 .

The condition indeed looks hard to read. Perhaps it should be rewritten as
"le32_to_cpu(ic->sb->journal_sections) == (ic->mode == 'I')"?

> 		r = -EINVAL;
> -		ti->error = "Corrupted superblock, journal_sections is 0";
> +		if (ic->mode != 'I')
> +			ti->error = "Corrupted superblock, journal_sections is 0";
> +		else
> +			ti->error = "Corrupted superblock, journal_sections is not 0";
> 		goto bad;
> 	}
> 	/* make sure that ti->max_io_len doesn't overflow */

[1] https://lore.kernel.org/20240729092807.2235937-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

