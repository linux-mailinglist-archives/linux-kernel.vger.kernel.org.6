Return-Path: <linux-kernel+bounces-382815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D79B13A9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6261C21827
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83910F1;
	Sat, 26 Oct 2024 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmAaGIUF"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05062EC4
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901063; cv=none; b=XX/0BdtdZCc/e+WHgdVAY+Iv/GwNJCJzsvmTNrWyn5eigMc8UtLa1dpfl7PTSjiTLdXfvX5hydViT3GLpOITSvV7FBbBTqvWMkA/wUuEpzzuPc6oiKmgudOERebKuGEYk2W8e0E1mLVO4bKIzrs5Djrhz7opBPwt3rsyIQlsPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901063; c=relaxed/simple;
	bh=cW9unEGNYEJweYtkOUGe/Tf0DcZOaDwHojevMTU2SjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir3ZjRrEjY6lcP/5s94WGtZ7wjrLKDcVL8OMzswa8l9IezNM4oM2dVzerSVGAF1i52muFl30qunfhUxoy4wZRpL2SpVqygI1q6/sxK3mrMu+LOf/LHQLQFW55dNu6Y+kw+TsRF3WYgHsZ3sAh0I/Ba2MVX4J7RT6vmCR6SQizW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmAaGIUF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so25955591fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729901059; x=1730505859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DwCeRCUXHM/LRQtCCTZFz6gg2/PPbwyNY2fCzshOz0=;
        b=TmAaGIUFkM3olFD3M9nL+MGTxj8mZu4BoJ/V8rf2cE07UimCO1HC/KV6Pbmu36vPxE
         AsW9cIgdj0x0MwIgZt6UrG0cbuN/zVm0ArDwUHVN/oNK+qtvXJz53Qa7FOCIYnl5jEN2
         y8WN0nNpb+1c8zYF9lqwPdxjgmMlo8BQHs/9MxA8q3LT487qQi/vXDwmw+TB9KRCUL3p
         UlgCok4KEW1o8JdWPJZZkU0j/VqJOyFEYUil8pQN5fkqEJzNt1nDbrJN4kZCD43g5Wre
         QbSWL3splRwTPsq0jvOBLwr8u7rYvp7tDo86VTAD1fobRaB9mQvhYsE5uGp0y1p7OjXQ
         Om3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729901059; x=1730505859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DwCeRCUXHM/LRQtCCTZFz6gg2/PPbwyNY2fCzshOz0=;
        b=CJ5m9NFuB0RVSoSz1glWyCpV5VCBse4qvgcxXLKFaExdeGyPsrA/S9PNRZRcNB+PAy
         p0iBZ4LsfxDYgiLyg5Lrz2l5ki6QAwTEprdNuFk7wfh1XWWa24SIMeAAHLUuzNlV59I2
         jXU9m+3tpoVa5frLBjM/l9Ul6nFUBtR03PufE0/FZSTnPCL1brH2S2Q3LMSaltMmbo5+
         XdygQivz1tT8UJEzCN6phTFr2q+6CnkZjOfdxDOjEXalFwOBjRijarCq+n6QGsuVPIIs
         F+VRMiSkcnbzPXKsfzS9CVlDwnGV8jgkQatNtqTKfv6u/2yspHK7kWuFbG0L4nxG78rN
         ZoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfkpKvEKgQx3uqWMRM0z7t493q7qVGm4sbz5cqgnwYYcl142hkk7VT1DlpuJ5oFY+LvyzIQIW+nkg4nGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9NO4ZpmYrgahy9Nqfg+tyazIzGLnl8gpE/4eC1otuvP3rJUt
	mdx2NjZxdL2HG5Ed6yOP4u5Ff2XZlzBiTRQkBdA447d48P6H2G3Lh/qplo0mFDpQ2xdhSaued1M
	uS76BjtVl9OWon9ZEBVeUcVji9CQ=
X-Google-Smtp-Source: AGHT+IERA4aBrz3+hUDNDk7Zp1Z16qh14aDW0h39JeE6hJohbjFh3kukh4sXPY5841UjAvfBLLjkg22FmHlHnFVzrFU=
X-Received: by 2002:a05:651c:b09:b0:2fb:591d:3db8 with SMTP id
 38308e7fff4ca-2fcbe078814mr4140211fa.35.1729901058732; Fri, 25 Oct 2024
 17:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-checkpatch-fixes-commit-v2-1-4bc4f06d37b3@gmail.com>
In-Reply-To: <20241025-checkpatch-fixes-commit-v2-1-4bc4f06d37b3@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Oct 2024 20:03:42 -0400
Message-ID: <CAJ-ks9nrTjWC2mF4GXQMMi+1QirbnSXDt19n6+15go4=kxeKSg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: always parse orig_commit in fixes tag
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Philippe Schenker <philippe.schenker@toradex.com>
Cc: Louis Peens <louis.peens@corigine.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 7:43=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Do not require the presence of `$balanced_parens` to get the commit SHA;
> this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
> than a suggestion containing a reference to HEAD.
>
> Given this patch:
> ```
> From c10a7d25e68ffd6222db2b63d86efa2fba04008b Mon Sep 17 00:00:00 2001
> From: Tamir Duberstein <tamird@gmail.com>
> Date: Fri, 25 Oct 2024 19:30:51 -0400
> Subject: [PATCH] Test patch
>
> This is a test patch.
>
> Fixes: bd17e036b495
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v2:
> - Added sample input and before and after output to patch description.
> - Link to v1: https://lore.kernel.org/r/20241019-checkpatch-fixes-commit-=
v1-1-0d0cde18ce69@gmail.com
> ---

Apologies, b4 got confused and put this in the wrong place. If there's
a better way to format the patch, please let me know.

>  new-file | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 new-file
>
> diff --git a/new-file b/new-file
> new file mode 100644
> index 000000000000..90b67dda6d59
> --- /dev/null
> +++ b/new-file
> @@ -0,0 +1 @@
> +Test.
> --
> 2.47.0
> ```
>
> Before:
> ```
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes: c10a7d25e68f ("Test patch")'
> Fixes: bd17e036b495
>
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> new file mode 100644
>
> total: 0 errors, 2 warnings, 1 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] Test patch" has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> ```
>
> After:
> ```
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes: bd17e036b495 ("checkpatch: warn for non-standard=
 fixes tag style")'
> Fixes: bd17e036b495
>
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> new file mode 100644
>
> total: 0 errors, 2 warnings, 1 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] Test patch" has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> ```
>
> The diff between the outputs:
> ```
> diff --git a/before b/after
> index d0cfdb243a1f..6f97b4c53080 100644
> --- a/before
> +++ b/after
> @@ -1,4 +1,4 @@
> -WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<t=
itle line>")' - ie: 'Fixes: c10a7d25e68f ("Test patch")'
> +WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<t=
itle line>")' - ie: 'Fixes: bd17e036b495 ("checkpatch: warn for non-standar=
d fixes tag style")'
>  #8:
>  Fixes: bd17e036b495
> ```
>
> The prior behavior incorrectly suggested the patch's own SHA and title
> line rather than the referenced commit's. This fixes that.
>
> Ironically this:
>
> Fixes: bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  scripts/checkpatch.pl | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4427572b24771ddb1f2bf3de3176f9437f643951..b03d526e4c454af7a42624155=
175e109d499762f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
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
>
> ---
> base-commit: c71f8fb4dc911022748a378b16aad1cc9b43aad8
> change-id: 20241019-checkpatch-fixes-commit-aa014fe6d0b3
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

