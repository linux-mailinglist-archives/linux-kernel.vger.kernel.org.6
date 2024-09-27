Return-Path: <linux-kernel+bounces-342120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5461988ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBB283933
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EBA1C2434;
	Fri, 27 Sep 2024 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d8cM4T2H"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E91C2427
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465848; cv=none; b=oeez2HLzgSAbXVEBpjFxJgs2xSYCfCfkzvQc7m2/LreBYTGzw1s6iZjGoZgbYXPC/XBeWbd/8f+a9ad08qlSJyWjzPKx5KF+TR++lNIyWIQT/bDZCEKs6LOPNMU2Vbbs5mm2qzlze+xDE1Qe/CeUGUDcAQn94zkkDmrsqvlCkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465848; c=relaxed/simple;
	bh=hzgXQd4meOt9YchtBa0oZc8snxmhRoTpkYPDbYyNMcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueYBDYsgefmPHVf0sbe51S8jWH04j+7MBJpJh5JfkAyo+mjdlvv/tMMaSEHPTkxEOx6rW2Ow5lEc3MfbPU3MHkawo4DN05hs8I9nffjXfrNCnCNjtUtHHqnQhZUsBjX1YwQNVbGFXK6YCnAOT5FXO1btLR9uupR+R1RL3+Zv184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d8cM4T2H; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so304470766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727465844; x=1728070644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGKYcXyh3V/E4diP4s63uLyqxym8fFf6P1DXJXOS0Pw=;
        b=d8cM4T2HKUOLwZn8nfygioxWnbRYbdYEI9phOzPWkdzkD88rqhSRwC/J63/DkOnsX2
         airqVCRL+c5dTsM1A+/CY/7QDtYsgVC2gQfiGXS0GRrtnImAx4Teciw+o29yfGdHIdPZ
         XlZZYBFwtx0uV72TK2KozCaKzPLmC8Vn+tIM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727465844; x=1728070644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGKYcXyh3V/E4diP4s63uLyqxym8fFf6P1DXJXOS0Pw=;
        b=cqPLHbx25kTp8x6spzbThyHk9q4nsipj3+7g0WgRv3MG9TfP7fVOgJ03IS28jZVnub
         7gQ409TT1/xlGag45puaZnsEKI4+1meSmuQ+3nEtGqMxC6BhAs8PjQMAfnn77y2tTbt/
         BCZ+mLBXqMhOEq+KSD9CZYlpkJNUc8m4gs+xXAPzmsBLugYZ5I8H466t/Y6BvDoSy6Ul
         l6lAFM3BbAGwV74D+w6FiEpjqxXYzAiI3CHfFjEhKpw0B/pBuaY73bKTAoJB7HDECdJE
         +x7ehKAhMMnpgq/dX1Rt2N2D7jRrUyxO9jVXl68K3kLQuEzjqsHSzfmspZi+EbTWFkj3
         qECw==
X-Gm-Message-State: AOJu0YzMSPkuKmJv/HSQGlDWrzQean9TbPNc9gwms9fR+7VkUZ0yqoT2
	fujjwFdFkOWFxoBRizQ4l2z++cygMmJtAQYOX13umg7PSLMpmM9hqq7WEP/WGd/iEQPqBgfXlxK
	HoacsYA==
X-Google-Smtp-Source: AGHT+IHoG2p/NL+Z6YGGHdZTiIbv/WBWTfW6R9m3FvTdJudeH8co3d99bjZZgtEzoZ/xMFPXG9k0WA==
X-Received: by 2002:a17:907:a01:b0:a8d:e49:c530 with SMTP id a640c23a62f3a-a93c4a671bbmr463648466b.42.1727465844494;
        Fri, 27 Sep 2024 12:37:24 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299e5bbsm166599366b.215.2024.09.27.12.37.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 12:37:23 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso365570366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:37:23 -0700 (PDT)
X-Received: by 2002:a17:907:9482:b0:a8a:7501:de21 with SMTP id
 a640c23a62f3a-a93c48e9977mr481536066b.12.1727465843370; Fri, 27 Sep 2024
 12:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvbeGKQMC1vFq8ei@yury-ThinkPad>
In-Reply-To: <ZvbeGKQMC1vFq8ei@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 12:37:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS9O67Ue9fZWG4ptc-MyZchqJmQFsMJkOchqpnxc-Dvw@mail.gmail.com>
Message-ID: <CAHk-=wjS9O67Ue9fZWG4ptc-MyZchqJmQFsMJkOchqpnxc-Dvw@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap changes for v6.12-rc1
To: Yury Norov <yury.norov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 09:32, Yury Norov <yury.norov@gmail.com> wrote:
>
> GENMASK_U128() is a prerequisite needed for arm64 development.

Note that at least right now, __int128 is marked as conditional for arm64:

        select ARCH_SUPPORTS_INT128 if CC_HAS_INT128

which implies that we may have compiler versions that don't actually
support it at all.

That said, I'm not sure what those compiler versions might be. Maybe
this is historical copy-and-paste noise.

                Linus

