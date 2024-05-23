Return-Path: <linux-kernel+bounces-187837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BB88CD937
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3427D1F21E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659E763F2;
	Thu, 23 May 2024 17:39:01 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943122943F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485941; cv=none; b=pelHOhQ4mOgQ+7qBjzerCbg+LmGhPKLMR4X3zikFANyoR7OySvKCKTI5Vcm6v5Pc3udjiNCV3++sPunvDD8TO0rF3m0FkM9GzI0RzwDHgjsUkM+vUnZWYehIgmSMElX+28M7tzsFy7Y7zeeoOQ4cKVSC4tCreYsrAHS6bXRrYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485941; c=relaxed/simple;
	bh=ykNO24/LLYJ1KpMLjZ7s6/Y6hamJXVNHx0AD5j7rXO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TJSaTnRmoUdSnO+4g37IJhnolo2ql9cdKLG7XgkFutCd/LKyWBo/lyxy+rqNy8SErRiPzuz4pOlk2C08wOqhCIqn55KHfo46qqFQ5W1cfFJ6+8ZUzp0PpPmGGXrtLp/uIA8GoLqmYIdBwVBIxphSYJqiYWnkYGLEeVn3vBZJdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f3406f225bso6917285ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716485939; x=1717090739;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/W0Vntg5VnIMxSV71l0bmPcwI99/cfB5C3Aav0qviU=;
        b=k2mh3oGrU78xenbvALyNMKkX5XOoJwTUr3E46/AzWg2WlAK4PWw01ffJ1ZE06jwhG1
         pZpIWOlg2ywvRItTVMwTM6x6zsGCDJTgozxzuX8qSmkjWtmPcF9zJzmxW4pVuca71j4/
         2vTCWMBo/q4IyloJ5y8WB3Zn6rSxXXhvOf2E4k4naHv2762XcsyUcKR6vrV0VNa98OKp
         Wh0TdbcdoFv7LOtIn843k2s4IXyrL7vcrht6clsoLvbfAUd8WcxgVeSBsvEyy5dG+4dy
         dEeNy2r/7UP7pPDq1EQbdwlhgY5Rf4xTV+adpUiin5Phu/kLKNP4UL/M2qFtidiUtOm7
         TQxA==
X-Forwarded-Encrypted: i=1; AJvYcCVfvn4QOurJ9exCOuCfIugm1fEVavHnNKfmw5KE2gjh9MREs6FK9zStFFAweAp+UMTe32LEFGqPESz83SXOxGJSk6Kzg/wBaQqDBqiu
X-Gm-Message-State: AOJu0YyoTljBVIBKw03yy4uJUqj1+jL2xegF5S920BvcamFYij+ThjPw
	ukDrgzGPeErJDT6g9uHV7L79nRn1JQEzheEawX1qq2ANXqLZDLqIG88Vwe1IZhI=
X-Google-Smtp-Source: AGHT+IGNADe/wyzsEZ266Ywm0cLtpbI9AmZBl0HV71wuiRh6eLHpIL1UEb3u967JpeQEc6fSHcuJww==
X-Received: by 2002:a17:903:228a:b0:1f3:1482:60d with SMTP id d9443c01a7336-1f449901aa6mr6505ad.61.1716485938797;
        Thu, 23 May 2024 10:38:58 -0700 (PDT)
Received: from localhost (75-172-111-169.tukw.qwest.net. [75.172.111.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30358e6d2sm71520115ad.93.2024.05.23.10.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:38:58 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, arm@kernel.org,
 soc@kernel.org, Antoine Tenart <atenart@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 1/2] ti: omap: MAINTAINERS: move =?utf-8?Q?Beno=C3=AEt?=
 Cousson to CREDITS
In-Reply-To: <20240520074013.9672-1-krzysztof.kozlowski@linaro.org>
References: <20240520074013.9672-1-krzysztof.kozlowski@linaro.org>
Date: Thu, 23 May 2024 10:38:57 -0700
Message-ID: <7httio2zta.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Last email from Beno=C3=AEt Cousson was in 2014 [1], so remove him from
> maintainers of the TI OMAP platform.  Stale maintainer entries hide
> information whether subsystem needs help, has a bus-factor or is even
> orphaned.
>
> Beno=C3=AEt Cousson, thank you for TI OMAP contributions and maintenance.

Not sure why Beno=C3=AEt is not cc'd, so adding him now so he can ack.

Kevin

