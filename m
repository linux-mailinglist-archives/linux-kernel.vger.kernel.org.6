Return-Path: <linux-kernel+bounces-521424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC7A3BD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0A53B0A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778501DF726;
	Wed, 19 Feb 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="YPRvAYqR"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4941DEFF7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965035; cv=none; b=ITONpPAL//drU95Ywax+kRZkdZ4MaFS9SEiH9Xi+riRi4kDI4VN+/NWfJhe3sfkByr5/0FS8eCEtDIK3WM7DPemRbj7ei3V387bAPAHVWwoZexl6aIEG4Dc6fVCu9P9i71VGofrCZnZKjYbpYE8vZicBgAVnAbJHtgL+7wNl+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965035; c=relaxed/simple;
	bh=b0/hGbzc5hLEd6R83g+E3AiFjyIkxXk18cvv2VlaV0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpDcqCzDRtI4NJb0oxGK1nOPN3alg4fINt1u/3bYU4qj8m+9kCdyXqh1ZYwxzGdINA5cHh7jfwSzO3CyjpX1xXVsPwZphchi+acWv7GrwPBqxz8gb2V63QhaXcc6WUpH50227VOUTdlWmRRvELRN10/hgYSvHBj9yAA6dxxH5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=YPRvAYqR; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id B051040B279C;
	Wed, 19 Feb 2025 11:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B051040B279C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739965031;
	bh=9+lYEc473PoSc/uXpeIr2BqdS0f3h4HSEoj/PNaHWuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPRvAYqRri3Lbb3Xf0kt0aF9kEC4Iq3qoZNzmIN/dXuL7AJ3lEbyJVzy3I5rU3RCl
	 GllF3fVzT7hWvL/n1UW0nu0+jgaqqSBDUS2MJPq/XahQL7LkgFQAR24VL656Oo1wyq
	 44WBXYC7Adf5HLjolI/qffwMw7aRxv52dGZTAGys=
Date: Wed, 19 Feb 2025 14:37:11 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	voskresenski.stanislav@confident.ru, Rand Deeb <deeb.rand@confident.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10.y] fs/jfs: cast inactags to s64 to prevent potential
 overflow
Message-ID: <tx4mjsvkleki6butsmbh533y6w55rt44zaorh6auhjyfgzunj3@oaiwslri6x5h>
References: <20250219072504.1655151-1-rand.sec96@gmail.com>
 <v3rsldvzq4ujgcxamjwcmmfm62wgdgjscg25c6t6xph3itjedp@sbuayguprw2i>
 <CAN8dotnkd-fSQurTFAf_8z3K1yRNj5SVJ4qYc3Tq7cVZLq02qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN8dotnkd-fSQurTFAf_8z3K1yRNj5SVJ4qYc3Tq7cVZLq02qA@mail.gmail.com>

On Wed, 19. Feb 14:10, Rand Deeb wrote:
> I focused on 5.10 and added it to the subject to avoid confusion,
> since files differ across versions. But yes, all versions have the issue.
> In one of my past patches, maintainers couldn't apply it due to kernel
> version differences, which led to confusion. So I thought specifying
> the version upfront would help. My bad, I should have noted it after
> the commit message instead.

The officially supported stable kernel branches can take the patch if it
or its equivalent is already present in the mainline.
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

> 
> I'll take this into account in future patches. Should I send another
> patch specifically for the mainline version now?

Yes. And not specifically, but deliberately (it's a requirement). The
existing problems should be fixed there at first.


