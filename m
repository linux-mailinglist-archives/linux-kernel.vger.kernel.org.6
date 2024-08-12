Return-Path: <linux-kernel+bounces-283046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D64994EC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F9FB220CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBBD14B95B;
	Mon, 12 Aug 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="oFNIYytW"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355041366
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464239; cv=none; b=SCWQd34PNNM0HUe1OY/3pejgIido9wc8bPg8Q+hj14sJJH9osDO57wBEtj5ZJAJ7r3kgR6M3jrnLxd28WmjZAre5/1cOZKPNt0X861etoG/m6x4JaHL3ay0PGAJb266+vbrKNbh1EpyVYVfIH62vqlbtXPRILcPk1o3ynoGxJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464239; c=relaxed/simple;
	bh=1CtL2wEPGtNYkmup9JH4Pxu3lkJZ8+OVRCzNog3I1d4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E8S+kfyGPGvHjCrhF8NDkV2AgKomNMQQmDiWtXJffJN0CUqfO0jsJqxN5l9xA9ER5/E0XyXsbnOPZG/iDGxwmWGM0kAIXZJFocTjjnToPDDYhUHPHPICNAdvMARLGZ2TFlLn/C0wX1ya7nZa/CPw3r6dv5GfEBEd6t+4ejYlWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=oFNIYytW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efbb55d24so7311450e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723464236; x=1724069036; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHB6Syh0cqRJ7/Goc9rsKVI9ZgMN8/vxCzgWlnm4/aQ=;
        b=oFNIYytWby3cQscxiJwBblsWqyiBMnJsbJ93DyHRAENd0KCevt7wHF7IoruhKLfztI
         dmR6tHi8FthiTfY/aW7Tl5ZmmJQ8fqYiemzPICCvdQ8nE0exbrTlFgn16um+immxokRO
         fLuJv7I5GmR4EnIaQqjvq3kM7P03hqYynNLJ9LwqGVwGUXVGEi8Vt0ZusEcjDOxDGtNV
         u5Updn8l+XlhWDECorL9KDwLkE3pafB7kzvZb4TKTLaX2UPFtJaB/qAfLaTyEQ6p/O2K
         97xu8E0pUlX8FsE5AqaPaH9ZMgX3pnGCx4tknszJXgYJ1HtuSTiBNlqPXXQ/jCy4q/9b
         pwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464236; x=1724069036;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHB6Syh0cqRJ7/Goc9rsKVI9ZgMN8/vxCzgWlnm4/aQ=;
        b=kmN9TiuMhJD272JZvyoggZZwbm4DgF2RIUXzoIEZBYpf3UkAi8fP1ejOriGPomAYJR
         tLs3ZF9g1y0wsV9UTiicJdGx8T5M3V8PqpUiFayp3988+PiXtJO8Co8pymskGifwY1aa
         TD5eGvOnpM20j5xjBZIvLdGWUWCcaICNLR5jpYFVurUvXlHrMrSWGaGXgeaGYVNkz+IP
         25Q9eAj3kT48uTZ6g1gYvv3wPKQOaigZ4Co//F1cvQX871zonBUR7hlWuwyDgJjzKP84
         RxG+RYcPy4qjfZxnzZDd+XCyWM0L28Y949OdIcxHiAcXEA/sbvEHRS6ojuDSJtEQZZZ6
         ji7g==
X-Forwarded-Encrypted: i=1; AJvYcCUJNkZrWKUbsWMoUGeu0KCqZsD0IaYNO0cNn4oIKtFX2S+9SKlYF+P9yri6dR2UalHRCQv5ycfnjYDsA9GGgNLo0V3rieSSAoZ59qVx
X-Gm-Message-State: AOJu0YyXHuYXd+viYvpT1axy5sTQYL2tW6HyhM70JcUFC1GTPklkHA5/
	qaDJk8Fdi+NJD5xwlxOzj72mE9DVwD2lJeL4eOwaFdck6EPZjr4E6Vdnl6n1eQs=
X-Google-Smtp-Source: AGHT+IEIBPq7k8bmmrdas9+km1vcCguP3K6w3+cBirOZrHyHEm53RRwXodm5mM+x7Jxa8GnLAChUbg==
X-Received: by 2002:a05:6512:6ca:b0:52c:e17c:cd7b with SMTP id 2adb3069b0e04-530ee98e033mr7616121e87.22.1723464236247;
        Mon, 12 Aug 2024 05:03:56 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:d9c2:3add:a642:dbcb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08fe69sm225021466b.43.2024.08.12.05.03.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 05:03:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] btrfs: Annotate structs with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
Date: Mon, 12 Aug 2024 14:03:44 +0200
Cc: "clm@fb.com" <clm@fb.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <106F3A42-A7CF-402E-B7F7-05AA506C5B7D@toblux.com>
References: <20240812103619.2720-2-thorsten.blum@toblux.com>
 <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 12. Aug 2024, at 12:54, Johannes Thumshirn =
<Johannes.Thumshirn@wdc.com> wrote:
> On 12.08.24 12:37, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>>  fs/btrfs/volumes.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 37a09ebb34dd..f28fa318036b 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -551,7 +551,7 @@ struct btrfs_io_context {
>>   * stripes[data_stripes + 1]: The Q stripe (only for RAID6).
>>   */
>>   u64 full_stripe_logical;
>> - struct btrfs_io_stripe stripes[];
>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
>>  };
>>=20
>>  struct btrfs_device_info {
>> @@ -591,7 +591,7 @@ struct btrfs_chunk_map {
>>   int io_width;
>>   int num_stripes;
>>   int sub_stripes;
>> - struct btrfs_io_stripe stripes[];
>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
>>  };
>>=20
>>  #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
>=20
> Looks good to me,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Out of curiosity, have you encountered any issues with this patch =
applied?

I only compile-tested it.=

