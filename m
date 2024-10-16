Return-Path: <linux-kernel+bounces-367228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2869A000A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3144F286D31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9ED17C98C;
	Wed, 16 Oct 2024 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G91CYnUU"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC715E5CA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052122; cv=none; b=aBzR+SmNp0nw4l1L9CeecKWWlTox/q7OgHO3vq4veaHAsBxLKX2P5qmVQCWLXS/+LB1nV3WWNXcTsyrcx1hvyz79ZRIJ0Tzf6NX3GVnajSNkOxQqxOFF7PAA8dGDNUctcIdwQ8j9ckljam4CnA/cziVdEWWqi3h33eUlb3M/ZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052122; c=relaxed/simple;
	bh=wgQQdOWRC25JFUOu9ttiBiTlEOY8XQwqpVLQtRLhHSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn+gNRRPETMgBKjoN3ZEVisCT8vC2u4jpa0aM4uuETxqUlnlmKl40Y1hd9uBknbq8JJjft/mfzDLljs27iSBcN/eIvJZZhaKKQkjAwRWCw5PX3Etp6/+p7XAY2Ht0kHwpM4pufJ7JXOaNuK+CIxED4VIeeyOK6BTFdS9Mdcr43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G91CYnUU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539ee1acb86so3863864e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729052117; x=1729656917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7oPk/m2XMb4zsXmOAcwGnkWPDKTdvg1ghHpep5dVFg=;
        b=G91CYnUUCak9ANpuDbLvmDtCll2BNZbI01YsnmxdMB0GBx0KI3FWA3Lr1eMGgAtqcQ
         tnt+7E3KqIthIEKcHtNfAOFjHki7R6eu+fiX7w3RK+TR7vnrJ7xFXItVObjfjMt8yT68
         f3h3Hnhc3UAezVgsim3J8iil5wvkPBWAHqBEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052117; x=1729656917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7oPk/m2XMb4zsXmOAcwGnkWPDKTdvg1ghHpep5dVFg=;
        b=apJYkcUlDA1MNSlXBAvVv0ABhNWM9E54V8b1MZJs1jHMNgGmTcLoYTaV1JCbDOqyKo
         BciNJkfgIhPiWUA4A0YpOEE/wf3oUxW0thjpjr2ZFLNsHZCp4AdppRHYXhKuA8UrKKpp
         KKNbZ2wNIPzs2TG9ebqWqDp+tB/RKI7UhTfer26+Wkbmp9IREozEf1pDsrUKmXBOUhaz
         F48qqBr7PF5tzJlELfPBZuBioCqB+ZOeGqd5KiJbC8ppAhvAqqQ2hcIQQIKdST2K0YF0
         Cg955krIzUQUSJku0jOana3y97fzxJ7+rXQATQdV3fmnyRBJuAuHjxvRjJ9Csi24O9oJ
         gKYw==
X-Forwarded-Encrypted: i=1; AJvYcCU52xzwZngzdPSQbdqGQOB1P8bdNbaFUvV9rD9h3urOVWcxdL4y6XGgHtWKfbMV42xdI8SqsBGcpo0CxO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuD1PQ2z0TG6/3u0RV9zvksbgvuNFKL4ctayzY35nWzIirRGKY
	TgpoVbjBeZ6t7VyJrmv9KmVzXw/zREqyukygZmXV7bVZMP87nA2K37WeQ0sDftyPsPupk0/aDLi
	lrfAEQpXANXQx6ygfASyTDaCmMz58Akyo1RYs
X-Google-Smtp-Source: AGHT+IGgZZN+o0s6DAvz10yvo6Z2yfjytPc/fZov8tMy/MAcCfeAieGw/k1jwKrbEbg01HpSnTMd7xY7cjHZurGxFX4=
X-Received: by 2002:a05:6512:e9d:b0:536:52ed:a23f with SMTP id
 2adb3069b0e04-539e540baffmr6810632e87.0.1729052117157; Tue, 15 Oct 2024
 21:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008082905.4005524-1-wenst@chromium.org> <87iktusfy0.fsf@trenco.lwn.net>
In-Reply-To: <87iktusfy0.fsf@trenco.lwn.net>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 16 Oct 2024 12:15:05 +0800
Message-ID: <CAGXv+5FrwPcYWR-XYEjeUPLCttjcwbVgD++T6PBXsW-xwiGOOA@mail.gmail.com>
Subject: Re: [PATCH] scripts/kernel-doc: Do not track section counter across
 processed files
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:22=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Chen-Yu Tsai <wenst@chromium.org> writes:
>
> > The section counter tracks how many sections of kernel-doc were added.
> > The only real use of the counter value is to check if anything was
> > actually supposed to be output and give a warning is nothing is
> > available.
> >
> > The current logic of remembering the initial value and then resetting
> > the value then when processing each file means that if a file has the
> > same number of sections as the previously processed one, a warning is
> > incorrectly given.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Found this while improving and checking the kernel docs for the
> > regulator core.
> >
> >  scripts/kernel-doc | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index 2791f8195203..c608820f0bf5 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -2322,7 +2322,6 @@ sub process_inline($$) {
> >
> >  sub process_file($) {
> >      my $file;
> > -    my $initial_section_counter =3D $section_counter;
> >      my ($orig_file) =3D @_;
> >
> >      $file =3D map_filename($orig_file);
> > @@ -2360,8 +2359,7 @@ sub process_file($) {
> >      }
> >
> >      # Make sure we got something interesting.
> > -    if ($initial_section_counter =3D=3D $section_counter && $
> > -        output_mode ne "none") {
> > +    if (!$section_counter && $output_mode ne "none") {
> >          if ($output_selection =3D=3D OUTPUT_INCLUDE) {
> >              emit_warning("${file}:1", "'$_' not found\n")
> >                  for keys %function_table;
>
> So I am curious, have you actually seen a spurious warning from this?  A
> normal build does not emit any here.

Yes indeed. I was cleaning up some kernel doc sections for the regulator
core and running both files through the tool together. At some point I
was getting the warning and not getting any output from the second
input file.

> The current logic is indeed screwy, I'll apply this fix.  But
> $section_counter kind of seems like a holdover from the docbook days and
> maybe isn't needed at all anymore?

I've lost most of the context around this, but AFAIK if we don't care
about not having anything to output and can drop the warning, then
$section_counter could be dropped together.


ChenYu

> Thanks,
>
> jon

