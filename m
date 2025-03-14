Return-Path: <linux-kernel+bounces-561230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CBCA60F04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E707AE2ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4821FC10D;
	Fri, 14 Mar 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STNXo0Ag"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD3D1F462F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948342; cv=none; b=D2DxbeQYqbTq1uJcIk8iGxvYs6iOseZcB7Fh96UHSod60CJ3oA7kBAFckJ/e6rR1DZmiL2zNmkKAmKi9ZyIjlhsKyfN+EypAEsG6adMzl3LSADsg3JghiYS5THy3AWFl8V/gu298M1wnB/X7m666z7QBdoy2vg3WBjMXAMjqaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948342; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geDNj0W6TT9dNtHsS+nWFlOsGb6viA2apaOcot216sch0tccdofMlCp5ZwNbZd3+xaMTCJOEK+KRcy2ea6oBYh7X79amxoVtrVBExeNnAQoBy+xD/IiI0op3MSnwk41b4q+/hBVElwpd8j/w+Hi8yTI7sh/6eoKSNxNyHFrWF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STNXo0Ag; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso13121625e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948339; x=1742553139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=STNXo0AgSPwzQ1wQ8bdVfLNi8q/ZVY8QolO+5GsaVANcVCU505ZVqI+P0J7vsDQ1bd
         f2M/p+oIUbG+RA1PBzvy5Xz4EeO7zVjsgdk3gylmoOsJDJ48tLX5lRV7xoBQugBAkW7B
         FWp7XVMRCrIJW6YybRWkfYPX+Y3HN4VHPjKlq+QaY925jmW/fIAJp9ES5gAGy4rrC1Ox
         NaTdJ8jZxywFdbL+2WnIaUjTFY2mbFsl/WwQF2mBykzt5Jy3eOmVsiZ3EXQfR1i2FY3H
         rr/09nl7/vTpB9cGD/Aif/eXuX060/RSuyXqZhi1mpeWqa4z8ry5CUxlIXhJSGi/RSZN
         9SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948339; x=1742553139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=TgjEh8k7vuNTGaLnuMzctp30+EPr8KKisQM+C+Om1i9+4yIVy0gXbuaSIBCKkMzSiU
         PXXFEznsl1rXO/sZwGbr+Qo9AtvglR28c7A2IQR0qtSnmm/Rc7ls2XZb9kWAt0+A/eaH
         enQwSRhDi/64OGUqQpNXyZVr4dhB7MSLEfemmcACuiFVCuJVF5nTiMZ4YHQf2Hw/A0+l
         DP/y5gJPiIQIDi6+u1d/0EtQPZ8WXmkxWh781kpjUGN+L37mOB5O/mOdt54N9ZexflAv
         6CWJVuFUMWTD2UG4ItwQll5py8/INA20b0U7k9sbhBiYkYg8CeOogN1/jJMC/EkkOELs
         7V5g==
X-Forwarded-Encrypted: i=1; AJvYcCUZxZdrGUA5xbhrGqxdDecHSyT5lGX8VMq67oPidzU86LfxuU5WvCdTbzF8p+g35FzWfhKkXSV+T/dOz8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsHGHald0ToQrM+mgEMB6RiDkdWWm41TuEgTOMoo9lVmocBp6
	IC5KIeukLZrKPDuf+XkyhIaO0S7IKqnRcODLoXkdOrKxubkT/gzx3W3rTLvRcCg=
X-Gm-Gg: ASbGncuay3S2X6b95PL19EPTmaktrN0dqPyX7yiPhC1U1HOQULii9pJjw20dpXwq2jF
	+hko2gHki904hx6m8XrNmrIMlexCrnQJXP9cE7aWHHUyPW5I1jqG53EsCL8uru06rk0O4zExEAG
	nBVxN8mShPwMN0VRmDcCSIeFFXPcutcaeBjIvL3BfmPX9PbaSf8RAWbgb1uVVzxizw4Weo+DMap
	kbNAinnQOzAZhoRpSbW0M2n1qNoA4PBNW1fK1dug2/Uz7JDi8mfwsfAf19qR1ov9nqf4W1beInU
	e5n5GitJV/VElqLOWpDKMYkHNBOQ2hCBa8mo29S+2CWMBTU0o9Ea4A==
X-Google-Smtp-Source: AGHT+IFQjVlKEgujwjT3Ubb4Yh1tGhuHYN5YVyssyzA1D8nbQwTyPMooOvvwbBRT8zeEV869mWIwNQ==
X-Received: by 2002:a05:6000:2ab:b0:391:1806:e23f with SMTP id ffacd0b85a97d-3971e7811a8mr2006308f8f.17.1741948339263;
        Fri, 14 Mar 2025 03:32:19 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35bdsm4990546f8f.5.2025.03.14.03.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:32:17 -0700 (PDT)
Message-ID: <f5946101-eef2-4e29-9e44-8a591a9bd42b@linaro.org>
Date: Fri, 14 Mar 2025 10:32:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: sg2044-nor: fix uninitialized variable in probe
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d343921b-16b8-429b-888a-f51bb6f2edc8@stanley.mountain>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <d343921b-16b8-429b-888a-f51bb6f2edc8@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

