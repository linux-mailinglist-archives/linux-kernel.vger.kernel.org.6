Return-Path: <linux-kernel+bounces-405960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FD49C5951
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D5B1F225D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1026156F3F;
	Tue, 12 Nov 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXc2Ku8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11E146588;
	Tue, 12 Nov 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418758; cv=none; b=JPsWngXwV+ZENCOui6le1RQQ2hQZqCIUVf/7RGP15+fyNtXI4xvMV0nwViEy8Ih+Mdw8XaY2rkJHHH/2W0tZxJ5ESkrlveCc01RYq2UWsS3eoXyN8C/i5vDn/h0mca/DLUcdSqc1FnupmvFdqJ2hNYopj3/134cLLXd+Gnid4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418758; c=relaxed/simple;
	bh=HTj17UKyqcpA32aPMJQ3rZjYn3JmkdLEXjK/gMdzqCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yxw5TQwRx1z6u7aqRkvEoEgpJHqytDS2mL5bAOY3YxQTzqROx/m2TFJbLC6vIOYBA447sd9FFaCT8ajP8fQbLTM9EBhg+6OawifDyrU+jH2Ct2akQTq30+L0YjHnqR+BqAEFgBi73Makmtcj7yLdeiqH9kEm1CZBQUfgornarGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXc2Ku8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F80C4CEDB;
	Tue, 12 Nov 2024 13:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418757;
	bh=HTj17UKyqcpA32aPMJQ3rZjYn3JmkdLEXjK/gMdzqCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eXc2Ku8/olNbsZEVPMf2palHyjma7qRQoxzHjERM5iQpNDbcxZLbXo/UiBevB+Lhh
	 E9q4n3mKGwqFVZnPiAD8J90B76XifpzX5JUdf7pWSe2puJS2CpVs4p3LE8FaG5BBLq
	 dSQyWUNosd/dgF8MyFLvZsYNE5cLRX4dEMyNAlm169VZcYicVeKGIWsUCClemBMSaN
	 bQdI4axDcgspd7KUkNBWTWB3Z019OKfBFBkqJEHw7PzLq8YHz+/P3NfGLWh60Qsi9Q
	 MlGLLuoyNih0/rVkWkTasPlMXZAUpsVAxW9VY8a+DiCeHTwvtwZy2mXF8SwJ/KtqKA
	 NONyY4J+evjsw==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so5410042276.3;
        Tue, 12 Nov 2024 05:39:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpPYnvUF4Ur9iYUthXLFbxIXea0CXiwwSvJsPyHke5L47cFqy76jAIQx0u04uZQZYG+CnXlqiPZuBB@vger.kernel.org, AJvYcCWTH7BuEJ/0UcYrbQfin/l7jE1k8mJ1MfHw/c5HJtn/96pCitmjkPDPNY3cqLVJB03M6JAStH5RH6AmrY7J@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1nSH5vPyt4696s5nTgJYBQ9Or7qTv6buz8uDoCXiZYMutD9b
	kYxi4ou5beS+RNo2eZNYPqA5UKcVkVNDVKtOJhV7HI1Byf79GGtnlexBgyfLSI85WuWFEommi+W
	fUW5X6Hb9qAvLC7izeL3ogJMPQw==
X-Google-Smtp-Source: AGHT+IGc8OfE6fahX5PrDtu1pkdAInjlDFVeCPxxhNJ8gOu0N6jx2xL+Bj/4hQIgNw4xoSxx9H8K2P1VyeuKsAdP/ss=
X-Received: by 2002:a05:6902:150b:b0:e29:1630:785c with SMTP id
 3f1490d57ef6-e337f840d8emr15583204276.10.1731418756964; Tue, 12 Nov 2024
 05:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110-of-alias-v2-0-16da9844a93e@beagleboard.org>
In-Reply-To: <20241110-of-alias-v2-0-16da9844a93e@beagleboard.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Nov 2024 07:39:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+72Q6LyOj1va_qcyCVkSRwqGNvBFfB9NNOgYXasAFYJQ@mail.gmail.com>
Message-ID: <CAL_Jsq+72Q6LyOj1va_qcyCVkSRwqGNvBFfB9NNOgYXasAFYJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Update aliases when added or removed
To: Ayush Singh <ayush@beagleboard.org>
Cc: Saravana Kannan <saravanak@google.com>, d-gole@ti.com, jkridner@beagleboard.org, 
	lorforlinux@beagleboard.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andrew Davis <afd@ti.com>, robertcnelson@beagleboard.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 1:52=E2=80=AFPM Ayush Singh <ayush@beagleboard.org> =
wrote:
>
> Currently the list of aliases is not updated when a DT overlay that adds
> an alias is loaded or unloaded. This break drivers (e.g. serial) that
> rely on of_alias_get_id().

Drivers use the non-existent alias numbers for instances without an
alias. So what happens if an index is already in use and then an
overlay uses the same index.

I don't see how this can work reliably unless the alias name doesn't
exist in the base DT.

> This picks up the original patch series from Geert Uytterhoeven.
>
> I have not added unittests in this version since I am not sure if kunit
> tests should be added, or if the runtime unittests (CONFIG_OF_UNITTEST)
> need to be added. Additionally, it would be great if someone can inform
> me how to run the runtime unittests since the unittests seem to fail in
> my current setup (tried running on qemu x86_64 and beagleplay).

You enable the config and boot.

Rob

