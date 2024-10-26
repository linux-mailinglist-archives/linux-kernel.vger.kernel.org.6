Return-Path: <linux-kernel+bounces-383173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF59B180F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD26A284213
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C01D5CD6;
	Sat, 26 Oct 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8uuspq6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FA1D5ABE
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945658; cv=none; b=mg/zvS84x4A5CBwiQgF072iBuJ70Eh0HUNeiDE016eqUadhnvH6IMrtay1lZbxlkZ6+RO7IqzhdehfT0Atcqak6RCQyWfEjr/8byjY+pFQdbtELwL0iuyfzoJEcBvIODifEmMVbnXiWtWmBhh32X/doosPGxeMfPdcPP4lsNhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945658; c=relaxed/simple;
	bh=DMxuc4FkxncyfoZmnLATdM1P+wBDtItNksGjIRWvADs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKWM5XTpHyM/6o0OP8wiuupdrQ08ISJCZn691SBDBgllq/lauNaUChruNOH1dA7Ryz6Y4W1/4M4y2+sXxYFU4E+ytgN6eNkd/R7rBxJdpJaP9fCcIgQkixGrQ5YO+YhWQKE9twJWXbk0JoGid3hEnm+zGzI8vxCANfkmBIQjflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8uuspq6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso30004711fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729945654; x=1730550454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTz7+mwaDjOBX3vLYUXOJxXMPA7UKCaRBLS71ajvXQA=;
        b=W8uuspq6u37gpTVjkvBZS40LFPBF7ZI7P/5IL91rEp3HwRp5NOsFwHMVPOH1GEakQx
         npyaMeZvw0DMTXH5bha94uKuyRCxl7veg6zoU+qW1UIU0G/1nSUv/EHDfmTB/FPnEDFR
         EXkGwidk0uigjvShHxBJ95CzbnSTMHWmaVtOObwp1yr85PzMvzPeRICZbm9dyRE1hTyR
         fR6X7eGXeI+TQudcQ0SSpH2UIE7XvOr2knptkh9VKEMJKnCLfOe3FOC12ui4pLML8ao2
         /fPd//elBs9Pkc0s93ytLR9J0VsYvZWimX/XGK3B/UO2ANQH5utyFtKhj4J7VBwQeIHN
         iaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945654; x=1730550454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTz7+mwaDjOBX3vLYUXOJxXMPA7UKCaRBLS71ajvXQA=;
        b=GdmrAAfpyRmkvSmpfu2bbcbYdIKk8vru+mm+0AfwoI9E1wHyoLRITemGKeEdwOu1x6
         JR8U0nX4pp2f5/BBY3y3N6b1d31MgynOYX/BRanDBzLFXbL2jDbPPldNgJwFjrHymM79
         Wk68lnCf8w5ruVddsuVyj4iq1+RxJVNOlJ96k2GY+t6e4vyQ9SHAMNaq7LsmzG7jnFep
         8fHJ9SbxVwONMG+CYHrQFks9KPSb6gn8Fj1Mq0ywgP5TR16U6JlJnkc6o4HzhEWHsrbz
         QyntmoNn1yKUhuuyJ5AEy6VhqLGfp7ati62ka/ocOhl+DR8s4baVCsOhFJwjsrzowQ3M
         hTfg==
X-Forwarded-Encrypted: i=1; AJvYcCXpilMyqlS5hzTireve4BDEHSfXWoGe7ogfGgEmd2gbichMotK9I/wItnSSEPiFgoybItdV9xrp9HKxpLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KHc9QpZipPpmKGQAJQxHtH2k51dNLw3+oRopybHMi4hCCzVa
	RFKxOaSPLjY9041RoBtRvLpmIPx8kXT1bkYjo1v5hwEir5on9A6paluw1xfO84hPjDmR58hML+A
	NDopRYDmYzhxYQJkM6103GvXCMRo=
X-Google-Smtp-Source: AGHT+IFmhb/AG+DRoAIBx7Exf3tqP9Gu1mCRk2RsdIULg+oS428vQDP/8WBg3u94U+XnjPIf7tmmQERKoS3KcFl7nRY=
X-Received: by 2002:a05:651c:2126:b0:2fb:6243:321d with SMTP id
 38308e7fff4ca-2fcbd8ee8f3mr8941881fa.5.1729945654131; Sat, 26 Oct 2024
 05:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-checkpatch-fixes-commit-v2-1-4bc4f06d37b3@gmail.com> <20241025174444.7536f7ad4c94fd02afc63077@linux-foundation.org>
In-Reply-To: <20241025174444.7536f7ad4c94fd02afc63077@linux-foundation.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 26 Oct 2024 08:26:57 -0400
Message-ID: <CAJ-ks9=AFHN_ZBGXcEk4HiJNpJUB4tBU6Kyrxng_hXC_yM0VAQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: always parse orig_commit in fixes tag
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Philippe Schenker <philippe.schenker@toradex.com>, Louis Peens <louis.peens@corigine.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 8:44=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 25 Oct 2024 19:43:19 -0400 Tamir Duberstein <tamird@gmail.com> wr=
ote:
>
> > Do not require the presence of `$balanced_parens` to get the commit SHA=
;
> > this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
> > than a suggestion containing a reference to HEAD.
>
> Got it, thanks.  Below is what I ended up with:
>
>
> From: Tamir Duberstein <tamird@gmail.com>
> Subject: checkpatch: always parse orig_commit in fixes tag
> Date: Fri, 25 Oct 2024 19:43:19 -0400
>
> Do not require the presence of `$balanced_parens` to get the commit SHA;
> this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
> than a suggestion containing a reference to HEAD.
>
> Given this patch:
>
> : From: Tamir Duberstein <tamird@gmail.com>
> : Subject: Test patch
> : Date: Fri, 25 Oct 2024 19:30:51 -0400
> :
> : This is a test patch.
> :
> : Fixes: bd17e036b495
> : Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> : --- /dev/null
> : +++ b/new-file
> : @@ -0,0 +1 @@
> : +Test.
>
>
> Before:
>
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes: c10a7d25e68f ("Test patch")'
>
> After:
>
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes: bd17e036b495 ("checkpatch: warn for non-standard=
 fixes tag style")'
>
>
>
> The prior behavior incorrectly suggested the patch's own SHA and title
> line rather than the referenced commit's.  This fixes that.
>
> Ironically this:
>
> Fixes: bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Louis Peens <louis.peens@corigine.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> Cc: Philippe Schenker <philippe.schenker@toradex.com>
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  scripts/checkpatch.pl |   37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>
> --- a/scripts/checkpatch.pl~checkpatch-always-parse-orig_commit-in-fixes-=
tag
> +++ a/scripts/checkpatch.pl
> @@ -3209,36 +3209,31 @@ sub process {
>
>  # Check Fixes: styles is correct
>                 if (!$in_header_lines &&
> -                   $line =3D~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\=
b/i) {
> -                       my $orig_commit =3D "";
> -                       my $id =3D "0123456789ab";
> -                       my $title =3D "commit title";
> -                       my $tag_case =3D 1;
> -                       my $tag_space =3D 1;
> -                       my $id_length =3D 1;
> -                       my $id_case =3D 1;
> +                   $line =3D~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5=
,40})(?:\s*($balanced_parens))?/i) {
> +                       my $tag =3D $1;
> +                       my $orig_commit =3D $2;
> +                       my $title;
>                         my $title_has_quotes =3D 0;
>                         $fixes_tag =3D 1;
> -
> -                       if ($line =3D~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+(=
$balanced_parens)/i) {
> -                               my $tag =3D $1;
> -                               $orig_commit =3D $2;
> -                               $title =3D $3;
> -
> -                               $tag_case =3D 0 if $tag eq "Fixes:";
> -                               $tag_space =3D 0 if ($line =3D~ /^fixes:?=
 [0-9a-f]{5,} ($balanced_parens)/i);
> -
> -                               $id_length =3D 0 if ($orig_commit =3D~ /^=
[0-9a-f]{12}$/i);
> -                               $id_case =3D 0 if ($orig_commit !~ /[A-F]=
/);
> -
> +                       if (defined $3) {
>                                 # Always strip leading/trailing parens th=
en double quotes if existing
> -                               $title =3D substr($title, 1, -1);
> +                               $title =3D substr($3, 1, -1);
>                                 if ($title =3D~ /^".*"$/) {
>                                         $title =3D substr($title, 1, -1);
>                                         $title_has_quotes =3D 1;
>                                 }
> +                       } else {
> +                               $title =3D "commit title"
>                         }
>
> +
> +                       my $tag_case =3D not ($tag eq "Fixes:");
> +                       my $tag_space =3D not ($line =3D~ /^fixes:? [0-9a=
-f]{5,40} ($balanced_parens)/i);
> +
> +                       my $id_length =3D not ($orig_commit =3D~ /^[0-9a-=
f]{12}$/i);
> +                       my $id_case =3D not ($orig_commit !~ /[A-F]/);
> +
> +                       my $id =3D "0123456789ab";
>                         my ($cid, $ctitle) =3D git_commit_info($orig_comm=
it, $id,
>                                                              $title);
>
> _
>

Thanks!

