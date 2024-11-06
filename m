Return-Path: <linux-kernel+bounces-397763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73E9BE002
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83566283957
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB81CF2BD;
	Wed,  6 Nov 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OoGXb3DK"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23519148A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880689; cv=none; b=mDkWrbsv95GRCIhuip86XOLDI++t+Bmc6bBCaT3OLBsygTiDFxMqRpTLMubnLNMCOTKBma+Zi/6NGKl/Ed5SGaYPmmLPMW9uRuat8/m4Ts1j5kxYRclgP1/OG0k9v7FattHcSwqf9EgRErtj4JPK2X7RikOTYFjeF/w2ZGfBGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880689; c=relaxed/simple;
	bh=WCMTSOtEeIUT1Du4KziJr3RbObN3+UpaGNedghH7IKk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N43Abu8x+3xWHvTYQY0Ch+oayNGzyDipiSQQ/Hxf4ObtkONaSta/MMlxsDX3oH43v1uD1O9yYu0IqUhtgAJjkp8Ox/gprjjrlvhcJoAJ2XQZqO1nH/vKpXaLZknUPu/Z+/RmgluTA8yOjfIgCbi7RY2mbMrm9iKAiR5uq9B/IT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OoGXb3DK; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1730880679; x=1731139879;
	bh=WCMTSOtEeIUT1Du4KziJr3RbObN3+UpaGNedghH7IKk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OoGXb3DKvJu2NiUGIk4u/PLhKENusFnxZNDGZtIkdH03hSirWA8cUmBxI8jCsz+O/
	 13Olz1jiwYsrq1p9JtHWSveyVTMuiZJr4teqGoXsspjXO+O8cHDdP0nRLIkoeEExI/
	 PS8DEqgbOOcnHjIWWAqhafz3wKfZ8xAq/Aca9Un5mLS3/3ma2Ow/nklZFuJ+Izay3K
	 6KnpHNgRAnnYHyQWR/T3c32hDELw+j0Jiauwk7YMW60Qnh/gW4p5Zd1GIEKN5ux6mN
	 s3WT13IJHtZnQEynTAvhprAoJNn+ONVDVmkxDthjnwcevvNtUBQG9UNnk5732Y9BhX
	 SJthZEUXChgOA==
Date: Wed, 06 Nov 2024 08:11:13 +0000
To: Piotr Zalewski <pZ010001011111@proton.me>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix wrong max check in bch2_opt_validate
Message-ID: <pkxqQnSTQLReyYEHegx90LNp5dbR6LlpcqUIkBFa2CiL-0P48QWpGJ1YYKtWwu0IFM7H-2T4fYQz0MldP6OqZppPzmqafQDKouhETLnM5o4=@proton.me>
In-Reply-To: <20241031231823.688918-2-pZ010001011111@proton.me>
References: <20241031231823.688918-2-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 1a6b9fb3156df086c9647ecc2e3ecef125742860
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kent,

Did you see this?

Best regards

On Friday, November 1st, 2024 at 12:22 AM, Piotr Zalewski <pZ010001011111@p=
roton.me> wrote:

> Use opt->max-1 in bch2_opt_validate when option type is BCH_OPT_STR. When
>
> option type is BCH_OPT_STR, real option's max is one less than the max
> value stored in option structure.
>
> Reported-by: syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbee87a0c3291c06aa8c6
> Fixes: 63c4b2545382 ("bcachefs: Better superblock opt validation")
> Signed-off-by: Piotr Zalewski pZ010001011111@proton.me
>
> ---
> fs/bcachefs/opts.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
> index 83f55cf99d46..bffcbe6a6fd0 100644
> --- a/fs/bcachefs/opts.c
> +++ b/fs/bcachefs/opts.c
> @@ -290,6 +290,8 @@ static int bch2_mount_opt_lookup(const char *name)
>
> int bch2_opt_validate(const struct bch_option *opt, u64 v, struct printbu=
f *err)
> {
> + const u64 opt_max =3D opt->type =3D=3D BCH_OPT_STR ? opt->max - 1 : opt=
->max;
>
> +
> if (v < opt->min) {
>
> if (err)
> prt_printf(err, "%s: too small (min %llu)",
> @@ -297,10 +299,10 @@ int bch2_opt_validate(const struct bch_option *opt,=
 u64 v, struct printbuf *err)
> return -BCH_ERR_ERANGE_option_too_small;
> }
>
> - if (opt->max && v >=3D opt->max) {
>
> + if (opt->max && v >=3D opt_max) {
>
> if (err)
> prt_printf(err, "%s: too big (max %llu)",
> - opt->attr.name, opt->max);
>
> + opt->attr.name, opt_max);
>
> return -BCH_ERR_ERANGE_option_too_big;
> }
>
> --
> 2.47.0
>

