Return-Path: <linux-kernel+bounces-438490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88F9EA1D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1593A2825E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31C01A0BC0;
	Mon,  9 Dec 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2oEjT8J"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90C1A072C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783341; cv=none; b=F9xkN3TSp4IcJyaKQHbET3NfDTP8pZLy4KmLL6M5uqnYWCXHX9TCwGujJqTWTjKLuPwGIPWt0/+T0nK7nBWjjfFkr7OfbdwqYWA+6mMQDiI5JeJ8JEQ8uq7nu1pfnYN3riHb4jeD5T+OyJsg2Tr867s3c+waJnQUT7mhSUIVDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783341; c=relaxed/simple;
	bh=fmVv2gGNgklMbUkcozHUJxBurwKxHcCdq2/A//J0UU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNHIxnDvBoSQz4o0tkxmY10faSLTMan+ZAAyOHYin7T3rjaPAF5fZIZNufcFN6Wp1yAnnHxYuqu/9KxpAs4Y74e5Mm5h8KH0MjetV4xb5RHb0ZdEru8sreonDAb65gBcqia7DtesHJcrRqW323CF5oLE2S27/aSiaxtnR+Ka0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2oEjT8J; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so23510711fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733783333; x=1734388133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ill4VZukBgvQ2l/LywNmR4dAYZT6rpODMh0dyNGQ/r0=;
        b=h2oEjT8JiZzVhvdLLTY0LqtuSVkH4532QtXr2GQG49X3Sq8K2IS6vmSIdx50x+Eb6p
         0OTKchfdw8/L++oIo8u+R6fdd+PlFJw/xBZxk8i+KCegBQ0cBNLEZEyQ7GwMsqozPMzr
         8kK75O3J1207z1j81visk6Gcx+s4CNk3V+UpHzBkzm4W+zANjkHex41qvN8zckgw58vH
         GJTUuhHW8HxQGuEdoAOoq4AMsz37z8kEOS5gdD4EHUdrY53Sem9Dba5qoiAChKUiDDXs
         sn5aLnHzePW2v4mr2xD63EZamSevmeMBhrCASQXmuJm4m6cxv17pOPGWJHhHHoUSl1D8
         UR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783333; x=1734388133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ill4VZukBgvQ2l/LywNmR4dAYZT6rpODMh0dyNGQ/r0=;
        b=GN6Oe1QoTFY9tRFoy/085cSh99ZVExgACHjbUFW1w6cYv2AA59omnVMTP1Glxu/DrT
         FJGfPIoM4UWsvhWKp2HhbAfInOSpEaUIPzacLzI2UkgN3F0oFcCoc3rr2GVlaSPlTZBQ
         KyiRgB4PP/Dy4icyVkk6xbWy4JOcZLZjDOVmFZJrn7t4OOod841yX0lWjLcz6UJ4cc9q
         FP+ZuA2Xromx+NbpWLjmEk3zB7fm7IzruyixbdIB4aG03RiCGSlg7oRi5W90yj8p3TZg
         wjh8kJa5ktR5K2CcWgJSdyK3rvt42UN9vP6efFAHJRzf+mpkP2YZ3Wsriax0907f8fK2
         gZAw==
X-Gm-Message-State: AOJu0YyIZlKRrRBZmuLgHJyrN97YbvNWqfvCAXFY6j47IS1qyzw/tPi9
	itnhO09DJXMXpiAe9FPtzsgAfy4gyRM3/3VjicGuILSez1x1cIZzfJW+7Yt/QuaQ3whBVAfSKy6
	W2x7T/bsg5euMN5GDUqB44IjoJNU=
X-Gm-Gg: ASbGnctQQ0Jotn2y1j8j9eAgAHVcUM275OUhTrfbn2X21QgrdBXCC2F1ZB6b1F15TrZ
	CfKYmL6ypM33pVODVC0Rsjco6vSO0/dmHfOf1oaJtXbsi4Ty7w0w=
X-Google-Smtp-Source: AGHT+IEV2gwyeFkvQq0GXg3JHfr2VnxMd3j7vcEhKARPf25S0ctcX7oV9u6dXRh2lC85K8K9HMlyMNo4VdRUIkS9GPo=
X-Received: by 2002:a2e:b896:0:b0:2fa:d7ea:a219 with SMTP id
 38308e7fff4ca-3022fd89f6emr7779441fa.37.1733783333063; Mon, 09 Dec 2024
 14:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-checkpatch-missing-commit-v1-1-68b34c94944e@gmail.com>
In-Reply-To: <20241204-checkpatch-missing-commit-v1-1-68b34c94944e@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 9 Dec 2024 17:28:17 -0500
Message-ID: <CAJ-ks9k_Tu8p9io9iyn4L5Brow+DdVDYdMqcDovfyjvOvKPX2g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: check return of `git_commit_info`
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Avoid string concatenation with an undefined variable when a reference
> to a missing commit is contained in a `Fixes` tag.
>
> Given this patch:
>
> : From: Tamir Duberstein <tamird@gmail.com>
> : Subject: Test patch
> : Date: Fri, 25 Oct 2024 19:30:51 -0400
> :
> : This is a test patch.
> :
> : Fixes: deadbeef111
> : Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> : --- /dev/null
> : +++ b/new-file
> : @@ -0,0 +1 @@
> : +Test.
>
> Before:
>
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes:  ("commit title")'
> WARNING: Unknown commit id 'deadbeef111', maybe rebased or not pulled?
> Use of uninitialized value $cid in concatenation (.) or string at scripts=
/checkpatch.pl line 3242.
>
> After:
>
> WARNING: Unknown commit id 'deadbeef111', maybe rebased or not pulled?
>
> This patch also reduce duplication slightly.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  scripts/checkpatch.pl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9eed3683ad76caffbbb2418e5dbea7551d374406..14639f83be91643245bba3aea=
6a980d50c04b1cc 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3237,12 +3237,12 @@ sub process {
>                         my ($cid, $ctitle) =3D git_commit_info($orig_comm=
it, $id,
>                                                              $title);
>
> -                       if ($ctitle ne $title || $tag_case || $tag_space =
||
> -                           $id_length || $id_case || !$title_has_quotes)=
 {
> +                       if (defined($cid) && ($ctitle ne $title || $tag_c=
ase || $tag_space || $id_length || $id_case || !$title_has_quotes)) {
> +                               my $fixed =3D "Fixes: $cid (\"$ctitle\")"=
;
>                                 if (WARN("BAD_FIXES_TAG",
> -                                    "Please use correct Fixes: style 'Fi=
xes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\"=
)'\n" . $herecurr) &&
> +                                    "Please use correct Fixes: style 'Fi=
xes: <12 chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) =
&&
>                                     $fix) {
> -                                       $fixed[$fixlinenr] =3D "Fixes: $c=
id (\"$ctitle\")";
> +                                       $fixed[$fixlinenr] =3D $fixed;
>                                 }
>                         }
>                 }
>
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241204-checkpatch-missing-commit-28b591b52dd1
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>

Hi Andrew, would you mind having a look at this patch?

