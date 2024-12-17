Return-Path: <linux-kernel+bounces-449147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC99F4A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C8216F2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6A1F130B;
	Tue, 17 Dec 2024 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yizJLmWe"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2271DF252
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436736; cv=none; b=bw1g2FqHj7SI9uKU+fu16GuCIwkwbcvLOZkWZXAgcli7XVNPev0Ft2532g9oQUIuZOODSfEQUaS+B402mTTc6iAfeI+7qmbc3U2PYN8g0KWgvO1dPw4wyAns9A5Vud/W2g3MF849Csi9lYrp+pCJiZLvzeCv1ZrvQDE//fvG/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436736; c=relaxed/simple;
	bh=soafBNLZ8FGsouJngfMjummC+Zy4UWC6gJKnUPp3ebg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VwtusIjnVauUVWen9ODI+ntKmKEsbRJGA0gk7b9pNjhUf4gf5lYknLs5ZgjUlnGi0xEZ+5qQiwO1dY8U1nuHROM94elIjmV4cvEf2coirodyI1cdvSP5Hiu3CZ6RGQI5VMxTDsHJUj01PUMAbUNODWVdHHVDIV3O6BBc8T3fpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yizJLmWe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436341f575fso38696005e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436733; x=1735041533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9hqEW7XeYBzAUP6ZyZ8OpTtmoSTfB8RARV4imdTM0g=;
        b=yizJLmWekfXcfAI/YzzzHnkncHvjUOq9CLDFmHWHV7gmZt+VAYCj1+Rqz4DMU+jfYN
         DssxO3UFy9NuI+mOc+IcHQ2/sV5xvWZEm302R7ifl+D6nNF5oZnAhn/sw9L+w4VK6W+5
         ofMjBfWxX0K5rT6SZmAb9OxDzfXvaA13dK1xysRuQquCNIOvbcHz1n0QJBeUhxa9EzDs
         X4off3nGdqtKYkNM8lILTR+AoDUWW4QyAOtllrpIgNfyZAuXZH/cSisI0/HIw7m34xg4
         6zl//K9sxYOv6y/EYSCPgVo/xyThy+q43kpUq2ylkrFD72GC54IgyVcsOTRSxa+5wF85
         47xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436733; x=1735041533;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9hqEW7XeYBzAUP6ZyZ8OpTtmoSTfB8RARV4imdTM0g=;
        b=s0UyH7r9AwtpuhJ16LqV4BpJb5j9ELwJ072pQ7zTIDvEbC8XG9ywcUSogY2sC6Ea9i
         XFZffNpLPPYWsaFIvoB/3gpFZqUijLy79knL8AiKS5Fa8wSJHMxQU4vIJYuRs2OKDxUo
         lhoqiSmHnN9GQAqYIKMytdetRLiplyKLPB2+6c4RKMJv2c7Q5OEsbzNf2ATOE9Dvfie9
         zL3Ka39Y2+OjewUt3OiB4aAZDOI2vY5xdLvm0rwoiDrc9NGW5GjQOBxmeIviatK5LkiD
         l21Y3bEyJlbqJtWD/N+2BM2kRUPK5rbN3VFIBpFSnbsajs0/zCURvmsifY8GY96H0Pmm
         Bw6A==
X-Forwarded-Encrypted: i=1; AJvYcCXkzb0gjJtFekuRk+fb5UPrTlRZeXxy2vTZGmdFXR9GVszz9bZnBuotIoZEYc+vKYrqbP99f1wQBfAh9sY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9mOSIillqawr/syWdNgt5pzUr+b06uvr8qQIQCLSBVNOJNJU
	hgWDaAumgaXw5nLyUmGUjLCzbsli7t8KG46M8VAVyzkBVlSwS4JKUB/o4TE7Mqc=
X-Gm-Gg: ASbGncvvIjCWushDW/c99gcdJ5SEFxOMhxVRuXTQw1OLFkIAWVl1FVZtD2DsyuA7oR0
	falZraHWwX+jMzhj+/t8kkBurJlKvRPLoIUOo2ncYZSQh1AQN7nTIGBeWgC1uek3gE9+Cab42Mx
	8uOHLUFPbz7naLHk2WkzyhDltBr4DS/jlEzeqWoFhtZ+j2GOGtfeIGZjPpPzrAcitq5JU5pOrks
	PW9E4e7mGNYhZvpwnsshvYYw7VVR6smvhq1xoiRoffhDYPNUKV7DJpxou6xDz0Yemodp8iMoQ4=
X-Google-Smtp-Source: AGHT+IElr3X/+n1C/bzd6Bueh8HghAIVp2JLb0iFduX7Lip+4bcYo3zxNwQH3qGvUMLrIOBL7Q//WA==
X-Received: by 2002:a05:600c:6749:b0:434:f817:4492 with SMTP id 5b1f17b1804b1-4362aaa6334mr172111965e9.31.1734436733370;
        Tue, 17 Dec 2024 03:58:53 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706caesm170318665e9.32.2024.12.17.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:58:53 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-arm-msm@vger.kernel.org, Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
 dri-devel@lists.freedesktop.org, arnd@arndb.de
In-Reply-To: <20241203053048.1690069-1-quic_ekangupt@quicinc.com>
References: <20241203053048.1690069-1-quic_ekangupt@quicinc.com>
Subject: Re: [PATCH v6 0/2] Add changes to use session index as identifier
Message-Id: <173443673261.58229.12529777015910898999.b4-ty@linaro.org>
Date: Tue, 17 Dec 2024 11:58:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 03 Dec 2024 11:00:46 +0530, Ekansh Gupta wrote:
> This patch series carries changes to use a masked session index
> as an identifier instead of process tgid to support mutiple PDs
> from same process.
> Patch [v5]: https://lore.kernel.org/all/20241202064806.1164800-1-quic_ekangupt@quicinc.com/
> 
> Changes in v6:
>   - Add single-line comment.
> Changes in v5:
>   - Remove mask and just modify session index.
> Changes in v4:
>   - Use GENMASK for client ID mask
>   - Add a new patch to rename tid and pgid as client ID.
> Changes in v3:
>   - Modified commit text.
>   - Removed idr implementation.
>   - Using session index for client id.
> Changes in v2:
>   - Reformatted commit text.
>   - Moved from ida to idr.
>   - Changed dsp_pgid data type.
>   - Resolved memory leak.
> 
> [...]

Applied, thanks!

[1/2] misc: fastrpc: Add support for multiple PD from one process
      commit: 0c3e383ce74b4239033fceb6f241cb09612f9547
[2/2] misc: fastrpc: Rename tgid and pid to client_id
      commit: 9f86299512e04b24fb0b4a49849affbb397780e1

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


