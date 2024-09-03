Return-Path: <linux-kernel+bounces-312735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79838969A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3085F1F24363
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB151B9829;
	Tue,  3 Sep 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5bzQwCd"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A41A0BEB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360367; cv=none; b=Bea8J5Mwil2zOFlIGEaKQFguwFx+ErDeYXUnAAOJquJ8ehreid5yjOyEQfp2I1I2ivOCnmjX3dg2yZ2WoZm36srrnVtJsiXg2mgAALC1Ek16nMBYYv/xzwQqlwLWYMfRHQELgizSj1s6uXeF9xyXF+Tnw2Y0P8uQj2JwO6zic3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360367; c=relaxed/simple;
	bh=x4wOACfhBpz70jjUabuyf+z53CYNd+PuF4Oofcf3HjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEeyCzAwbH0b2lRPKzDlS1x8C16Fh05O6m7WSDUTaaNzVMHgL5NuaGv5yqXBqU/J1sCj6oErywjtc6UzQN5gW0wRsAnTsXxmlzwWJvu276VgySnOEUa8WVrjN2XS+Xiwghdk1g6QhiBs9sr7ozAt4P1o5iWWeGwZpN/qRsO3w6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C5bzQwCd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a868d7f92feso563150066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725360361; x=1725965161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eim7jVg2zMGwDU6gtUZM1KJ0JKIpgjrRjdBz6mKYyTs=;
        b=C5bzQwCd6vJ0uRTdVQLFQ2vHGdQ9Yz5fr6KFm9xpsR+wbrtDwBwXhxwH7ZMwAgJXzI
         dKke0S7dB2mWh5n8DAKg4BKbELB/ptW7gJSg5YxbChyPPuGi0FmqL+4u+lVGawdvymww
         M3ix6CSghtpug5oL9Q8Y4a3vehSCs8Ltblq977x52qwX9s2gLJKNRbo0K4zTcf8QolOt
         fUqVkymZcLX0maHPF0bwKefulIGtbOjGV/dqIOrt8woBhF5Bk6bfFGyGlU7Rn1NJrtJC
         qhkmcyCbFLA5Ukt7dJQhYB2yn0k7d8BqixHBp0aNQJRKzjfRJqVytLwms/WWG/Z9tAWz
         9Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725360361; x=1725965161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eim7jVg2zMGwDU6gtUZM1KJ0JKIpgjrRjdBz6mKYyTs=;
        b=AF0GOnYhvLNYZNoqg3bHLsHxXX8qgLQDD/YCLPISFvV6WQIr2lzmBOYO/2u0ZAhS3a
         Z7uI7zcXI9REG1h6R0iq4ufuSgBPsiLyJ+WISy7splnpO33jvUkChxNn7eELzotZGFVL
         vB47hUJP2YP6WEMH/Kt8BBih3ImBXtTlgiMT0uDZrvQmRM8PAPq6x7fp3XxJKBASq5Xb
         EAyahQk5OeI1hGf+iZW9/IB8g8DAa2djJac0hRb/0lCLQAcKhgF7k0RliKHBhHikLVnL
         xEO/YnO/IJ6xFSBVJvoAJ486oDzUEwNCiVJzZWg+8490JL82sBnSM/YB+ceHjaVKczgz
         zeRw==
X-Gm-Message-State: AOJu0YwPlMQTyG1kV7uIE5nxVrjTRGouGQEnMj/lNGevTXpafiYPDSV4
	XAq4M4OHLH70mB0jhaQG8ePmvMxx4srQ9u2vsprxLTibk7E2/OPzOGcREiQT9IY=
X-Google-Smtp-Source: AGHT+IHkX5WjXkscz8L7VVSypNWlAoHzqWYLeRKjdV623Q/mO9KjVoyIeAUJRPoXGxPpGd1eOmlwzQ==
X-Received: by 2002:a17:907:9487:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a897f1c3e3dmr1230082166b.0.1725360360557;
        Tue, 03 Sep 2024 03:46:00 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a898900f603sm664706966b.74.2024.09.03.03.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:46:00 -0700 (PDT)
Message-ID: <a326aa34-a683-4efd-af7a-f2f264c7fc4b@linaro.org>
Date: Tue, 3 Sep 2024 11:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvmem: fixes for 6.11
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
 <2024090351-monument-hydrogen-f495@gregkh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2024090351-monument-hydrogen-f495@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/09/2024 11:20, Greg KH wrote:
> On Mon, Sep 02, 2024 at 03:25:07PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Hi Greg,
>>
>> Here are few fixes in nvmem for 6.11, Could you queue
>> these for next possible rc.
> 
> You forgot to cc: stable on all of these :(
> 
Sorry Greg, Should I resend them with CC Stable?

--srini

