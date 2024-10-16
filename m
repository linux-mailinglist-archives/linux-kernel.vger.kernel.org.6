Return-Path: <linux-kernel+bounces-367563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371AD9A03DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32A51F22484
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E511D172A;
	Wed, 16 Oct 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JyWjrpsN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6C1D0F6B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066415; cv=none; b=lLhyOuoOSHmIwuBMeJ1x33hPzFDAvBS1WbE3dg+9+ZbLLhrTTk1oB/LN/h8YRlpfOzHq9TE07qiEO6kKwfEvCTgv0ZxFFF6MGHo7QLHISseLIi4RCJpK5l2YB1812Ai+9VzyyqdYZO1+rIOEizTWytTnfSSdm8CSyEZre3z6RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066415; c=relaxed/simple;
	bh=JtG6b2NVxTkV9p8jCjA1H+O/WXABGIu57jSCxGsFYsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekdohfchF6xhL0FDeZFFyyK4nF/MNji4WG/1I8Zl0n9Q5aCScEYg6EE4Ht82CcdHVW/CArHalYxOf2C8Lsj/C3thgafKd+stT3L321hajbe+BHV7AwXyceT0SVurlDUuOiuHIbfA+YMr0rUDSQ+i49gUt/kgrzdJhNXZzZykmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JyWjrpsN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca7fc4484so31228015ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729066413; x=1729671213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtG6b2NVxTkV9p8jCjA1H+O/WXABGIu57jSCxGsFYsQ=;
        b=JyWjrpsN24kW6WslUVardMS/hgo3MNl7AoJnSy/21rzYHRzv7DlXfUBZoj63yL2/mc
         1sV8C1OgsTWkxrgcCBihbIyZSVAIBzmgKjRDna0fiH2aRoRfHMuHkwt89h6wevIzxA4U
         PqmOhkpMEZPlmk2tdvcrz3vVuvJ5wgHZgsQkiHg3/fK1LgY6bJeqwvl387Axj9KAZN3q
         SR+UEcm797odkuHy+EQqzfjI0qHVJ/DVPMBWxvhm9PoLqDPTF5sG0obkf9cEf5RJYIaO
         46zvlv75WbuOOC+JWUWrKqpO10/xLl0PzlMV/k1M+jYDI+T7yV6Ba2MYCHW+Le2geCk5
         HcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066413; x=1729671213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtG6b2NVxTkV9p8jCjA1H+O/WXABGIu57jSCxGsFYsQ=;
        b=l9uJv7XsD5/nijfrPh5mddwydZZY+KzOA4XYh7PHJ8b2dX36lPJ8rhdxt0odi+360u
         ghZc+eo61kpLIzONhi9IRYZ4fHdZPmwvvxYo9lXQ+wddZdZvrSy7dtyWAFX9J66+fXAf
         4H2pp8tvhjiVPVY1ztyPXBmPrlTdwCnPPFUYg5lHaQ4m3hrA2Qq9WwMZCGpR//H2HHsK
         ZV2Pi3L9jO+8/kU1COfwFFtUKe/KeFpW0G152ug5LFMGRBHYEL7toApdJcTX0KVUziQ0
         p1jQ11zZs8LYlW+481XC1zE+b31M61XVy81SfW1JLI2ej3HEsETTJhnHU2vNKMa2V37P
         HIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi2VidH5IvJp0+tm88WSGLKtGoswn537GoGt3PbPg9sB7gsNdq69KAxYmrYveafEo8+aeuS+uT1OGytpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAtdlGbxvWAlDtD8bWIRdKWitP2IEmsscivuYlDanegZxvic/
	oxABK73xZEfVtuvb5bVaYQGA3R7lFKL+e5pTYMOV9dWweupGFaW1V3DPfrznKBc=
X-Google-Smtp-Source: AGHT+IHZLOY/8uCT+YzO5BvcN2dZ04an0Mp2plL55IFvjie8wwlI4YAPfrv7CIkhfHTVsEk0R005uA==
X-Received: by 2002:a17:902:c952:b0:20b:7ec0:ee3e with SMTP id d9443c01a7336-20cbb17d5eemr254331975ad.11.1729066413524;
        Wed, 16 Oct 2024 01:13:33 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805af9fsm23745675ad.241.2024.10.16.01.13.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Oct 2024 01:13:33 -0700 (PDT)
From: lizhe.67@bytedance.com
To: hch@infradead.org
Cc: akpm@linux-foundation.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Date: Wed, 16 Oct 2024 16:13:26 +0800
Message-ID: <20241016081326.45277-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Zw9zVQs4Jp_oUpjM@infradead.org>
References: <Zw9zVQs4Jp_oUpjM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 01:03:33 -0700, hch@infradead.org wrote:

>> OK I know what you mean. It is indeed OK to remove "extern", but all function
>> declarations in the rwsem.h have the "extern" prefix. I think it would be
>> better to keep it consistent.
>
>They are pointless and should never be added.

OK I will remove it in v2. Thanks!

