Return-Path: <linux-kernel+bounces-375458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218679A9634
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE5E1F226F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A915139CE2;
	Tue, 22 Oct 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kepXlu+y"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7A1EB31
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563734; cv=none; b=bsOCQkGV+EY2WjlsF063mK5S/VkrsnJP8PsnhvpIDV0pRxidO0cNBk/xIdAidY0oZ31TMJcTZQWIpjE7DZMtQ5tdn3jdnJVYbowvx9bd4x6klN2MnbOi/UXJea2irhd9lFEHK2EYeByZxj/gYQKcmnwSDSsVaRWl1AmxhKB517w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563734; c=relaxed/simple;
	bh=2wk/ia+DfxJskFNHk5gFp5fbnmf/RduFsxkEWk1z1ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6DZ4WXkEVGupfYiGD1tweuGlZed1n5ubPJB3oF+SvpkRS3gsZA5vJLlr+ZCCaDw+8b15k4/hdkwm91dDMTBMLt19qVrmMx977Cp89sxT8XsFCcon9gnrg5wo+7SdGkfY8eFggRscAW9I0rTpoGHx7dylpY4eZKTQWl3MjzjvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kepXlu+y; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso76921741fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729563731; x=1730168531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dP/1zLItRwsWsMFKUQO3O2m0U956G15luPQkQx5lVRg=;
        b=kepXlu+y6MLYAbibqvuf+sUVg9tYjaRINrvLPZ9hLEOnanx46Uui9GizGVASIpUNUT
         eKKs2lntBdQd8UZMImEnSNqgWkcmUz1bLqp05PO7hqCFlygG1N60G2j/bfagJH6GXZ8w
         U0/K+fTAwWqX2JniYUlSIawsIPnFoVwgKQdMvP0AAYS2V0tJWJ5zzfn8JPIUvgTrLhcI
         vZJ7/XpiDn44uPBcF5yHHKYNC8qFURxpRPy4Yaj3N6sr6VVGvwjkjrkTPoRThftTSgkM
         uVUAiAyAygvaBUDeYrg4SuS526sW89/+D0EPCNL3gO8v6maTEf3kQcOF3xDhfpe8ZBw4
         A8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729563731; x=1730168531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP/1zLItRwsWsMFKUQO3O2m0U956G15luPQkQx5lVRg=;
        b=umVfKhTcuR7DFP3ZJiwZW/If46fkToHQw/bJ4968ppjLXWSc26/21cQUqeSx/g7qOs
         p8H760Etdc8e6zZsOUWkZmoXe4XgRJp3eeKJG8IzqkJYp8CKe6tYUQ2bdUFoyAMfL8Ib
         iw3JAwoXAt6qnXOjJoxhiUEhCwbu5JGIxue87htucv3c7Zs/mJmG5BJ7gfZAafPGRIOo
         90HDofEqBO1mIkb2md8BU1cnGxxHWVJnajdSvFs3EQegk6WZ4Nqx153kO86NfYog7lRx
         uoAZsWuZ7JueevHvtnbyeCFEzmMy7soyMDJPn1UzcZzewn7iZqjHDvZP6fc1WtlwHTsi
         Nbgw==
X-Gm-Message-State: AOJu0Yzr39/ixqmF4hM5y2Ipl+TMKeIZCa45s4QETS0doM6iuZ3DTZew
	7wKeK+6XFG81uNpIfZBbp760bG9aFcQExZC/yH6rolexFihMcfQyPfiLAXdi87lPosKcM2A+32f
	3TUqMsKkGxWL4IGPy8QqCCSE0rEc=
X-Google-Smtp-Source: AGHT+IFIHBhTIrINa+942kKcHu4JESvnpDXp2U0L0G6dHAEA++V9vHmaX9BqMgkGCrYw/zEYwT6zZvyi6BhZ92ttQ0U=
X-Received: by 2002:a2e:70a:0:b0:2fa:dd6a:9250 with SMTP id
 38308e7fff4ca-2fb82eafea1mr74879121fa.20.1729563730373; Mon, 21 Oct 2024
 19:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009102303.49473-1-advaitdhamorikar@gmail.com>
In-Reply-To: <20241009102303.49473-1-advaitdhamorikar@gmail.com>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Tue, 22 Oct 2024 07:51:58 +0530
Message-ID: <CAJ7bepLkkNSTu528WFfwmb9p06jRECu3hQ5avjC9C8VSyLmuCg@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch: Fix multiple Reported-by: false
 positive warning
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello all,

I would like to kindly ping for a review on the following patch.
I would greatly appreciate your feedback.

Thanks for your time and consideration.

Kind regards,
Advait

On Wed, 9 Oct 2024 at 15:53, Advait Dhamorikar
<advaitdhamorikar@gmail.com> wrote:
>
> If multiple Reported-by: tags are used, the
> checkpatch script throws a false positive warning
> even when there is a Closes tag following the two
> tags. This fix checks if the closes tag is present
> after multiple Reported-by tags.
>
> Here is an example of the same:
> > WARNING: Reported-by: should be immediately followed by Closes: with a
> > URL to the report
> > #10:
> > Reported-by: Kernel test bot <ppppqqqq@ymail.com>
> > Reported-by: Some Person <xxxyyy@gmail.com>
>
> > total: 0 errors, 1 warnings, 0 checks, 8 lines checked
>
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>  scripts/checkpatch.pl | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4427572b2477..c74519f02180 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3188,10 +3188,13 @@ sub process {
>                         if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>                                 if (!defined $lines[$linenr]) {
>                                         WARN("BAD_REPORTED_BY_LINK",
> -                                            "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
> -                               } elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
> +                                               "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
> +                               } elsif ($lines[$linenr] =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] =~ /^reported(?:|-and-tested)-by:/i) {
> +                                        # Do nothing if the next line is another Reported-by:
> +                }
> +                               elsif ($lines[$linenr]  =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] !~ /^closes:\s*/i) {
>                                         WARN("BAD_REPORTED_BY_LINK",
> -                                            "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> +                                               "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . "#" . ($linenr + 1) . ":" . "\n" . $rawlines[$linenr] . "\n");
>                                 }
>                         }
>                 }
> --
> 2.34.1
>

