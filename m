Return-Path: <linux-kernel+bounces-190516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226128CFF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23E62845D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D615DBAF;
	Mon, 27 May 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FA1RufbY"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F9115D5CC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810745; cv=none; b=CXlvI1BvYRe6gYL9KlVM/hITgFU2bquoL8TVpMH0G0KWlBV2lDXU5dw5HvxGkfWeLbxtD1cy9UhJwjkzF6WOOH/9d1TiObg7kqcdGvUtgUGxo8HUVPEKsJTZNIM44YwZFIBTmQ6zf5mKxlCZARK0qNsp4Nz0Dv3wJUYqUhCQ8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810745; c=relaxed/simple;
	bh=VX56rnXRKZ4GZp7DhgrvBoDhKbX3+fonAEYJcg+waYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QsSi2n4LFPS4/gw+GiNAUhpKFFqjQpDFxWzzfk+MNk9f+Sm6txmrAKuCi6WtErH60LqhxvuxClpa7bydFBpoilYjIE2EWFdbHYMUeKfXJ4uTeK42sVLGUd9/VdxZiykSb9LuL24vu1yiP118IC7fIpHVqxxEtHdLtmciWI3b3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FA1RufbY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6303e13ffeso63986166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716810742; x=1717415542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkZKEHRogInqNtLsLBUNlCz9zgxCOF3F9HYZOMBlaRQ=;
        b=FA1RufbYg7mvkjHj/aN8e/2ehOTe8ghjBOxrZtD8eWcz9q5q7wMQMxr4qG8pOurbmA
         OoKXEUkTdbJ+WIr6G7TFYgoyRPfTdOgQ/nITskjkBLLIRvj5reweRZ3ygHWYC5+MVCo+
         1gHE64IiWQfv8CU+CsKVycg0M6WqqAKxTYyNa/KZnDxh49iqtq8205WtVVLIxW0xBvIa
         eOkeRBa39XS6xQB7mnamMPcuABXvBpPaT9jFHc3kcCjo+ooSJcXneYBqHwO2Ltzk8o87
         Q05K3c8vjVUrKvc+q249c/m35tb374W09lnG5TjjRbCGBSHCTYvv8UKoaGzKzyxrdny/
         Yynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716810742; x=1717415542;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkZKEHRogInqNtLsLBUNlCz9zgxCOF3F9HYZOMBlaRQ=;
        b=FSX9BG8FWyEoOxMWdoF4bsKCXvnDeNeKtuVyx9TSYlrhRXIB0L5JIhRRLL1mNGe/hv
         o1IxBwlGkqDja6CiRV5OOWaG4drLJNvJLKUaHtBFvaE5i8T6VhICnFcK3DugFfgbRiGp
         FcysKw55IZL/OCc7DIB5KrTNaj0UvtgIdiDqAePsezK9TBuHpVxL2DzJ05RJ4J8rBZdm
         HQODW75/uWB5K67NnuiSXMgJ+cAn2l+t9aKNC8qavfzl96WKfjhffQWZlVNmPHVKxAtZ
         s1TolCABQRUWZdugVvPZ8hH00w5pFbYwkTz6POKsRrOKhcOt6weRwIaqAeOK9FHFAdZ+
         KJtQ==
X-Gm-Message-State: AOJu0Yyi7l5QO2COerGl4KbgkxKWTahcgxlFvMEGqi0+kEQEsBeHAotz
	cfKUmBFUGMNfcrGAyZN/TKERMgC61LrPU8vTWYvvsgjGMgrFBfEh+ewDPOZ3kIM=
X-Google-Smtp-Source: AGHT+IE8YSg2ZASS439EBMOzBbI6ZiX5OneTYI2gGvIFtmqcAV1kDcCVnxRECc3ErKpML/mDCWhb/Q==
X-Received: by 2002:a17:907:728f:b0:a62:fcf7:8924 with SMTP id a640c23a62f3a-a62fcf78a9emr151448866b.60.1716810742152;
        Mon, 27 May 2024 04:52:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda8481sm480417766b.213.2024.05.27.04.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:52:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240513204733.291673-2-thorsten.blum@toblux.com>
References: <20240513204733.291673-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH] w1: Fix typo in dev_info() message
Message-Id: <171681074107.111295.12987693727650566606.b4-ty@linaro.org>
Date: Mon, 27 May 2024 13:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 13 May 2024 22:47:34 +0200, Thorsten Blum wrote:
> s/exists/exist/
> 
> 

Applied, thanks!

[1/1] w1: Fix typo in dev_info() message
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


