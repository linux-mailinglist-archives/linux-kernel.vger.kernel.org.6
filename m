Return-Path: <linux-kernel+bounces-197316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6278D6936
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF73286D80
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674427F7C6;
	Fri, 31 May 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gsZM7OMH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA327E58C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181398; cv=none; b=FoHnuolQ97kgK4PDo7SMeR+iXfYW0Q0tc1AbzPEOgPWIbSkYFixgHj3NIFSM72DmPer79cGhWY95EohuA3msutSl5NKjJoI6Yq84jebeCVs3yfoOapUEGO/jGWoc9eUQh+HmHjqq/JT5HYqhlKZ9WU9P4lNdxm0lVOBxWP/L5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181398; c=relaxed/simple;
	bh=+k2+ICccda+4JfnoM3HmzO3GJ/eyjrpDMyrYptT3BPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSVkX6c1uP0WREpQHnLBRO6LWoqRmPy1/pJ167P612TS4XtEJxMPK6I7c3GuxWNheyMJGD2X2Y7rOpRwVPMni9YMXBDlB1VwUYmPSqcjQ3d4PfeMYkPaSysKtAl8Ii02PlfOkONXYaY8se2k0uzZNFnplauTM+ao2zbfwsczb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gsZM7OMH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a673a60f544so178853566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717181395; x=1717786195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=itW9AwEPlcHDr0HplS3dAf2ENLgkkIePx+3YdEWFfiU=;
        b=gsZM7OMHVamDezpAJVj0Ago5LPa1Xqw1zIlsZq8lGZdxrhhdnAri5q1i7SoWQsmFkR
         swBiVpQEW6C5J0DS/4x3tenDX9BAPTXtwYLD2+fInxHxB5mP5ncvnCJjfaeHN3z37RYe
         AuaEJDo+yLIhgdX0yCbnTiO8qDECpAkd8D1do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717181395; x=1717786195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itW9AwEPlcHDr0HplS3dAf2ENLgkkIePx+3YdEWFfiU=;
        b=R72BUgUyJoM0hfsc786heyvFz0Ug4FkqzUWIYsTAssbvuiy6lF/lKdAiu9eRRifQ1O
         Ced31WuZ0yOvaUNFx8cBw1ZkDRbQdQjvRvZhXr/qKtS9uGQ3grrsVWEGx8QoFBZQkEma
         DK+buWT735hNKSVcDfM1jOQH6c1Q3VID2Uaiib1A7eGNLQFGZAK/O5Ldf/KULxc9AsJ/
         593uqTFT0/lB0m8Fgp7nycuBYqeguJAkFDCnAeX8ieYqx0EnN3t/M4ukxWoB9qorUOBa
         joluApa2aCWs3YjiI6uMD+dGOI2bz6r4FdWNqBmpUUjHI0P75O/oaWLvDq9wLyisOhsg
         aF+A==
X-Forwarded-Encrypted: i=1; AJvYcCWfyYdgakXC8LnZN5lMdNmJPEFZa3h0x6l8rfR3lovK9AEdZ4U57PMsWvrn1u0C//rdQJR8PJWIHVfyHhgbajUusgd/MB0kTUn4wEAY
X-Gm-Message-State: AOJu0YwMjW8JwanLXf/I18+msYy9uu7K3+TG0t8fPka1yvQxm4krEeps
	7/99FA6VgNw7C3xOLELahmPRu75y4XYCV540oN054g8W3DtSSwyq71ylmHHDMz+Yufl+p9Eg1XW
	DlJnKSA==
X-Google-Smtp-Source: AGHT+IEA0mabx5sjylXmqvd0/pRXRGMO7pRdj7JJRx5y5a/j78fiWo6CjCD7tKl59tOgIRRXffXXbA==
X-Received: by 2002:a17:906:158c:b0:a62:2ef9:13d with SMTP id a640c23a62f3a-a681c5f1057mr192883366b.0.1717181395341;
        Fri, 31 May 2024 11:49:55 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85f1asm112951566b.182.2024.05.31.11.49.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 11:49:54 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso223141266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:49:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXK4xCBF4hp5gI1UgLV7hkaZOkYhL7MXbmnk1eQyfNF4SjdaG/m7h4B985VhATe7bDHBbT2ApTjNiw1TfcMxTpGh4o8C1Rs5plxqzVD
X-Received: by 2002:a17:906:378c:b0:a59:9db2:d988 with SMTP id
 a640c23a62f3a-a6821d647bdmr200744566b.50.1717181394333; Fri, 31 May 2024
 11:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530132944.37714-1-pabeni@redhat.com> <171718117960.32259.11784216389309914917.pr-tracker-bot@kernel.org>
In-Reply-To: <171718117960.32259.11784216389309914917.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 May 2024 11:49:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh13CTo4vhVUMPSxEZsxJa8JW68Dv8=-Sd6V9Sg4fA42g@mail.gmail.com>
Message-ID: <CAHk-=wh13CTo4vhVUMPSxEZsxJa8JW68Dv8=-Sd6V9Sg4fA42g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10-rc2
To: pr-tracker-bot@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 11:46, <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Thu, 30 May 2024 15:29:44 +0200:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc2
>
> has been merged into torvalds/linux.git:

Technically it was merged 24+ hours ago, but I spent yesterday looking
at the arm64 user access functions and for some reason had just
forgotten to push out.

Oops.

           Linus

