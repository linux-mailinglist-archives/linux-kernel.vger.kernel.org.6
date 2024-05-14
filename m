Return-Path: <linux-kernel+bounces-179243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD68C5DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE72F282F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF6181D08;
	Tue, 14 May 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cehaMXCZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE61DDEE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727138; cv=none; b=l13RtKEBmPGKh3/xx7jfnPFnnTLNTd4cS+t3C18ZKCCo9jelHwJhQ3xefH54KzOJekDikS1mB2A8leQujV/PLRd7HI0L7hSdjN+YdWIKjt0UZUwQUUt4LaOn/2WiRCj9/bLXDoOWqCGkyqEAlEkKuEuOlI97E3TBuKw2v43j5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727138; c=relaxed/simple;
	bh=0qQ/sc8ONfKMIFEbDmEeKbk7hGENEC1CjPvuVVbodHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDVL+KEhkZDK8QYPbwQzqP1faqReSO6nlfe/jV3lcU+QH6y60zR3LBNLNSq36Z/ljARnL24asx+DT/s/fYRIJsd2hZoMPJr81Ild5Pw4TGEe2mX1WOWsw8fDnIIwa04yyuRmWC5t63smsPV6NxNq2JW09/nBIl+r51LH5DSEfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cehaMXCZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f05b669b6cso34172975ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715727137; x=1716331937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doHLoOzkV1dAkjUvPPZHC9iFmwa5zDfo9zpyMOeSinc=;
        b=cehaMXCZsoHjkoCKuFRGlwA8Pol2JIcmEEQ5QYIN5sX133TQ7eYmIa4kxehoHZniWG
         /2F7Vdo77mOz666RMRHPSyfwGmyC/mb2qdoGmyo7R7+xdHnANd1Ke8h3h+JOwvZtlyBm
         N7lOz+uxMjMaMTOIQ6e72M5J9Eor8nCs2ec/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715727137; x=1716331937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doHLoOzkV1dAkjUvPPZHC9iFmwa5zDfo9zpyMOeSinc=;
        b=HfaygOH4q6ImkEk9ixvum6oSm046MCyxqizOLrAnb64nG8gVRDxPV2SsTc3EcVYOuF
         geic3sENOjUo9ZtwLXhsXEavF1Wx0kY7ALQXgJL/kpwNuiitV0OZanRpfMqHJbbwZdNa
         v7S0/maFP+TSEv86qxpL1mwLBL3SqIGYGDt83SUDmdvrm63GDPKtHulIqOu5sYDdqKVE
         AVGY22D5oBI/zR4CbfIdxkJiwCxEiwW7laxkfvYGrpvP2bhxKGZK58NSBmiecLQjkX6P
         OeNWB7YHp4eyuNeVj1JjoJ2X56ozkPqJXzG11SP3O7sovi0abMaMvx4RyIV4Sedo1dsi
         f+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCcGtvM1tc3C1M2OS3u+D209DDAVazs4n98Qc8JZmfqaYSJpMo9Qdt1GsrxM/CD4dJzLtkwqgWTGCmotRtpy+ywG+NOApJClD+wrxx
X-Gm-Message-State: AOJu0YwoTp68o02vOHy+CMTdIpkc7y3tNS0lPY1jGcn9OL0jfkfM8zqy
	/oeVsFrbKGMu91PCakaE5OqbfCJcghnbXzvPI2szI9wmwMIyyrDVNvic3Vivag==
X-Google-Smtp-Source: AGHT+IHWpFc8GRFfiX7fNqiCpm4+31CydC2UjP1SeqwBmoKCvpRAbRtb3mlF4Yocsg9frEgmjAbqMA==
X-Received: by 2002:a17:902:8f94:b0:1e3:c610:597d with SMTP id d9443c01a7336-1ef44057ca0mr125104875ad.60.1715727136930;
        Tue, 14 May 2024 15:52:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad886csm103974935ad.70.2024.05.14.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 15:52:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Boyd <swboyd@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression
Date: Tue, 14 May 2024 15:52:13 -0700
Message-Id: <171572713190.2793228.3146950773342970247.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514224839.2526112-1-swboyd@chromium.org>
References: <20240514224839.2526112-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 15:48:38 -0700, Stephen Boyd wrote:
> If modules are built compressed, and LoadPin is enforcing by default, we
> must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
> Modules will fail to load without decompression built into the kernel
> because they'll be blocked by LoadPin. Add a depends on clause to
> prevent this combination.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression
      https://git.kernel.org/kees/c/bc9316c14441

Take care,

-- 
Kees Cook


