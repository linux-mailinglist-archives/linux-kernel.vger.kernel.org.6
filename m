Return-Path: <linux-kernel+bounces-393945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555269BA7BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80628183B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19C18991E;
	Sun,  3 Nov 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgJwdjBh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123BD14F9E9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663557; cv=none; b=qbo+09iucldZcdVMXyX432eI5cIF0tx3AeUTyTxEd+eNLolidz8YcKqwambQeMlwe81cvPdn+pefmvuaxrl+tLr0kEaARZnhfzPSctLHGZkywqq2pPNzxPzLwkPtATf47B2MuW3qnmIh6ys/fT4lHV+Rdum+PNEdLMjcBLZN054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663557; c=relaxed/simple;
	bh=PQegQn3+8/PIWx8/Y7AMCPnrxj3hemTpvdg9V+17eCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne+cohX0ztn7JKNnTnrPUgLgnOqgC2nexMyG4e1cGE7r4JB05bN1eaqtBDb8QrhLFENEeIroi9sXb5slDkSKkheWR83VQg0NXLS0sW2D+0BmszsYzTyZpVMK9bsEOq3uAUDmyCRcdmUtxjueh4FLk95lD8ujSr3bZU1JFsCEbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NgJwdjBh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2138999f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 11:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730663554; x=1731268354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9HRwxuKA5SYPrf0mycwo4kyEZVXW2KTXgvqsO4ho/A=;
        b=NgJwdjBh9NP1ZCCji8ErlDAw1rE/6dF/R+pXWdwxVY/qnFcLj/P6MuDz2d6bk2fSE1
         8Zu5SUQfYL9u2rUc3H1nsbVaJcu3rxIEDkqVvXC1gFA4epqgpnhWPLz6+B7bw+5rBlF6
         shHYoFoHH+2lW3dgkC+9kaRZ7fSgMrchf86b6FtaQJ3ZmPejKuUPO9vReCqLknLOTDfK
         V5dXFyrnYAUE/Lm+FaqqP1agM9Sio6YDmaUpAGpeZMjDKmOe50HRsapm2MimusRLxEf5
         FmGGYUG8P2AqjP2Cu5tsTiIizfk7gFCMtqMCNuH/1rVGX6iSfIvj3TkcwQj0GbVILYMn
         nIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730663554; x=1731268354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9HRwxuKA5SYPrf0mycwo4kyEZVXW2KTXgvqsO4ho/A=;
        b=YEihrhjgPXkQFYh38YunbWH6qrW378sQnZ+ARXa4E0hq6E5VGctZlWCKydLhWD5qRE
         TnlFrMWvJmXfuxjVsTOgC7tw4nzJHuXsuDG1fAGUGs53GZpLfiONoA5vAElE2IfVubJ8
         brvLvegRYVAhmRsQtZADaQhvfTmxyq1UuQW5KMr7ALDD16pH2YEEStaMT/J0VmYtcbG/
         4jqhyIW7sfb3D+qwJCtk59F2QeG/bPICjvFMSABDJYcuQiSGPu7VLMysnHnOY6yVg6bA
         IYaBGnH0PRnlLAIKc7SiTrTkiWJNG7pR5e8PVoGZ6kATXxOHrk1xIUyXooI4u1gaVAjq
         SWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQWNkTqSvRUExa3KMaBpKTmGlzwSUnAMHexmAJ0cE/M2obkXdInIHavh0KEYK/mIZA6WgogDm21Xa9EkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozwpU+GIewILzMT8O3x1aCgwiOzXTE7291vKGpJe3Tbl3l/JR
	+R4qcRr8SFPa4ZhDuw+uSz8E8I9oDVAd6W+2XTNJPAuam3pc8dVMlf7y9HpHgXg=
X-Google-Smtp-Source: AGHT+IHRlzR/T44vFTA6xhju6BevgdlpguiQL7NPllDCW6AH3Dy70BrbMRmNdc01zD9C3OYhha4t6w==
X-Received: by 2002:a5d:5888:0:b0:37d:3f81:153f with SMTP id ffacd0b85a97d-381c149f226mr12298762f8f.17.1730663554250;
        Sun, 03 Nov 2024 11:52:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c10e61f9sm11272153f8f.58.2024.11.03.11.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 11:52:33 -0800 (PST)
Message-ID: <d9f946a3-44d6-4973-859e-60aa2807181c@linaro.org>
Date: Sun, 3 Nov 2024 20:52:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: timer: actions,owl-timer: convert to YAML
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241103123513.2890107-1-ivo.ivanov.ivanov1@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241103123513.2890107-1-ivo.ivanov.ivanov1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/11/2024 13:35, Ivaylo Ivanov wrote:
> Convert the Actions Semi Owl timer bindings to DT schema.
> 
> Changes during conversion:
>   - Add a description
>   - Add "clocks" as a required property, since the driver searches for it
>   - Correct the given example according to owl-s500.dtsi
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
> v2: update commit message to be accurate (Krzysztof)
> v2: don't preserve formatting in the description (Krzysztof)
> v2: add allOf:if:then block constraining per variant (Krzysztof)
> v2: add a blank line after additionalProperties (Krzysztof)
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

