Return-Path: <linux-kernel+bounces-282919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A994EA8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7B1F226C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A9E16F0D0;
	Mon, 12 Aug 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsT9R+Jv"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499D16EBE0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457507; cv=none; b=tjdibFLsyhO6ARkmTo0buNm/pZNNJkwVupnYsicGwdwn9ZQG01oYwuafDn1Yy12RoAwinVCnyO+IqbVArgcsV5dsSOUZk5pFSalhSzQdTKi8ORp2PbBKVk/SzdnQYuRRA1LxLMyqf4OLZjntAazcbg0MDl0K1Dfz4/CqEP94oQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457507; c=relaxed/simple;
	bh=B4enY+rrNBSkdAFyZxhkPC8jeXmTObRDrkCpJiKixqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6nlZA0YcdZ5ERj7u/6J2SP1DWhdVRSOax4DoRxeqwkD16ab19lp7HP+/bzQ6A5Tr+v+WiuEdVnUhxq5K7NyAAZMUEtQPiIJJLKQGGyFn3gTE3NkayDP/L4cSfFe4M346XCMdeE+knUO/nnuQ8uvwAYLSwqdX2IJ+nOJn7fF3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fsT9R+Jv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368f92df172so2086632f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723457504; x=1724062304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiEwTt/nhsAbq5aVUbyNSi+3qGhJTSod5OddfESv4fc=;
        b=fsT9R+JvsxxS9Q0FOpMyqDB7GUeHAx76BQnPqJ/yKavNovcEphUDruDy+JxaW/w74T
         +XxsZb9GOCWbGepqVLZTL+Wc+8QuHhFs7BVJPmnvgSTiPBRyNDFPJqK+iMbBJkj3BORZ
         zdKBOz9kVYPqkPHtUZ+akF+v55FeLzMxlAhf71g1CYaBINzIqw2EenQc5MxRwuR/npNm
         d4aQm+ySnlyuiaAidoM/4Qb55CimIXdA3NBFl3QD6Xab7gUOKo0jL7X1FHLl0fzm+/aO
         zN/RQ7FnvEezOf8lKiPAROvXEUyqXdkIyoZkaA+JzJUzO9mgKgsbimyy1Gb+/BZ9diSb
         uGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457504; x=1724062304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiEwTt/nhsAbq5aVUbyNSi+3qGhJTSod5OddfESv4fc=;
        b=f1O6BOjw9juLawrY/EfCNbAQ269BxAsm0sZTEC7PsOJChcwyQlf4vi4ap4hOLPYiDi
         qIRXjDUJnX7LaTn6dz+kZc7JlubkIGKF1cdUIm8BknBAaQ1X80RixCdL4BLoQu552sEw
         EgFjmJKiR3cKeN6uVYiUNA4EdgdaOiJXfdias8oB2T/I1yzW0sw/c/nJUNgD/wkpRNbE
         czQVz0eRLZ6OCPUBx6oqq/DyukQ6IYyIOtI+aUZYy0Q0lEWrFL9Q6hz49szHjOsoSE3W
         GewG/TWNbe5ycY8w55DRyMjIx0/YZVG61UeVU5tXekBNZiqJ43jhbxJGIFawMnYQGjdU
         kOIA==
X-Forwarded-Encrypted: i=1; AJvYcCUa2Ocvdj3Cs2QxYPx8BKjJPCIXXTr1OEfLsJQZGVwCkRtCN9kM924i62eyQon1mkGDKwTI7h4yUdmWA9I+z4PJAg6BUxBu62gz/O+I
X-Gm-Message-State: AOJu0YyhoKR32s8SyfNWxDYFf/rqrTHfl86tsuEw9IcFKkwVC37QVIi+
	3rFY2wMQqmicqzNSywOk/cNhrojjVBEMmrm/qyMzDgbS1GAhIYQOdXHysmOA1yNFOK9QOh/avX+
	z
X-Google-Smtp-Source: AGHT+IEroR6dN92+2LEJNO/Bpv7fHpk7cuzuCAekIqeAe5t1pHd6sxVkl/cxvBxzytgLBLzPuHbddQ==
X-Received: by 2002:adf:f408:0:b0:366:e9fa:178 with SMTP id ffacd0b85a97d-36d5aba99d1mr5397058f8f.0.1723457503803;
        Mon, 12 Aug 2024 03:11:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2accsm7054591f8f.90.2024.08.12.03.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:11:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: realview: Add/drop missing/spurious unit-addreses
Date: Mon, 12 Aug 2024 12:11:32 +0200
Message-ID: <172345744173.104566.7784022936514071509.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528191510.1444068-1-robh@kernel.org>
References: <20240528191510.1444068-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 May 2024 14:15:09 -0500, Rob Herring (Arm) wrote:
> Various nodes on the Arm Realview boards have missing or spurious
> unit-addresses.
> 
> 

No one took this patch and it waits on the list for very long.

Applied, thanks!

[1/1] arm: dts: realview: Add/drop missing/spurious unit-addreses
      https://git.kernel.org/krzk/linux-dt/c/71aa9fd7b5dee10a620f0938f3df8a8818a7f232

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

