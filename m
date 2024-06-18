Return-Path: <linux-kernel+bounces-219178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8A90CAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF761C22C33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A27153517;
	Tue, 18 Jun 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KW1i0k9q"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11284DDDA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711771; cv=none; b=LxkGyeDyTs3sq13vyf7k2D/U1evdsNCuFCCPRo1bN8p6vSnjEzNXYyC2E94eswhtj5LonXpw39aru/+Yj7spJB1MrKbky/KTePRFQTCe9Pxcopv/G6VVYyPrSeao/8qI6Y6R4p2rsdFQe70kBuQXwsZS0GxXSAKo9FKVldVc358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711771; c=relaxed/simple;
	bh=jpPEB/6YZTPYLy3RYj7LOJsKZCfOADwF3vloVsYeags=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAR0I9L4d8DlMYYeVZV3Fu/27kBxLlIYZ+LBIpGEcqwO+8veFJx5+eS3jF2wKaEkj7DTvplxe9sa+3OMsyvMmVugguvFBITv/GJPEbqAjZ4KRMXMYE/v/krI42fgwiMkaMswtLFS38IpEy4zZy0DsH26aRO0NG88XFlWjs2lbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KW1i0k9q; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cc10b5978so1545330e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718711768; x=1719316568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mq75lZPvciVQwZ7mi6K5o2q0ASdayZBfX3qCcW8QAuE=;
        b=KW1i0k9qj0DskKaCd1uV1Dlm3Ignkxrap9uKQr1wHBUc6iiPcmYL4bQAjj1qoJJmk0
         c6F4rsmFO2rpCbPJimWUuw3b/2paE4eA1VjbNXnPDQtPl4UwRx8hltyorbVoKUQsJR0F
         F5N3l6JCZdON/lrLnQnFxr0O+AuQGi8nW6B9hLXQ6JGfv+hcEBf2OZMcsrJEc17WwShE
         VhQOy856Ii6Jj0/DukJJ1KLdp3cD2uqKrRQKt6tJwm9VfyxAihYjcScdd3RsBApNUT1Y
         kEjNdXJ7LfXm4prHCAVvJRbmRTzOuEaRYWPLFINadyXml5OMfkCXffUwg0hqUf08wYw+
         5Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711768; x=1719316568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq75lZPvciVQwZ7mi6K5o2q0ASdayZBfX3qCcW8QAuE=;
        b=je4uW0smDg/B67z4SYj9PKSFckIGb8DUk/5ZTlS1sBLUEvZ70pccg/wmM0eh9aUoJk
         rhoR7ezYNst7j23YLcpCyduFFCH0KkAAQowfIC2gKrSdmhpq7IkmdfIT8IfAj6dgx6zd
         dOCGpgy4EX1BeJ6vdigDc/Iqtm1GC0FtUq+xXJ7mjXZ8rszQk6Q0MH4pS/VP75eZD97F
         8MLLQWBY3qwBIN0rR+/eYJstLKEc0fG6ZOjDepVKqXivyhHryuoFmqnG8BzYCLEQr0Pu
         /PxV6jMqrgiwMZul5O2hd57XL4B5bpmSaSNQqmF8orRKnU8DOUDSO/ei65YwkIUla8Uu
         kB2A==
X-Forwarded-Encrypted: i=1; AJvYcCU04EhNp7RYp/0clkHfSh4+W61NSiDj7L68ebd8OHOfKTf1JKsZQAZfiSmFxOTwYTYi1F16HRvPqp0sgo9fa8wiDAB7eRCcILhx/t5M
X-Gm-Message-State: AOJu0YzJtXmrJ14DjL5ne1KzQxxu5FJuC8mY/yqaDZVYRl78ECGi7zUN
	/J8TMtaJHBl+4qLFSaFxdLFr6vYvm/3pxs2d2HrOFqEfGggU0yyANLDs8LQ5p6U=
X-Google-Smtp-Source: AGHT+IEYh8t5Lf/IT2gzYEj9aUFut5HJwk0C+UH8HgqmpV5pG3oPCZTtmSV1TDxS2pKMtIogxvp+lQ==
X-Received: by 2002:a05:6512:3b93:b0:52c:8206:b986 with SMTP id 2adb3069b0e04-52cb621b577mr6055207e87.56.1718711767941;
        Tue, 18 Jun 2024 04:56:07 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28870f5sm1487968e87.249.2024.06.18.04.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:56:07 -0700 (PDT)
Message-ID: <c807a7c6-ac17-454d-9a99-1a221038774e@linaro.org>
Date: Tue, 18 Jun 2024 13:56:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] arm64: dts: qcom: c630: Add Embedded Controller
 node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nikita Travkin <nikita@trvn.ru>
References: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
 <20240614-yoga-ec-driver-v7-6-9f0b9b40ae76@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240614-yoga-ec-driver-v7-6-9f0b9b40ae76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/14/24 01:43, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <andersson@kernel.org>
> 
> The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
> and provides battery and adapter status, as well as altmode
> notifications for the second USB Type-C port.
> 
> Add a definition for the EC.
> 
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

