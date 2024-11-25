Return-Path: <linux-kernel+bounces-421599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A49D8D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19A8286CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9741C07D1;
	Mon, 25 Nov 2024 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Op8YMp9L"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F46F06D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566780; cv=none; b=hqFf8ggqXWkMa+h/qLWWnxOErNvUWgSwf5JmW1jj7Bc0JzLx2si6DwdeZsQE19d5KoLqw3nafm7Ic6y6jP2h9z7z3q/FEYAfEibnCyi1b/UXsPY4nRO4nzt01jOD7DyePfWJoqIvRwlge71+2V6Wu4YOsL7IsDTtpZpm221k1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566780; c=relaxed/simple;
	bh=WjY+Fq28smnHxNVgx2xkhej5EXhlkMnIB/YCuVo3TqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ievc+Nv+NxyiVoIarpGNLxuH8YpZ0HzapF/7G++rosJu4qdy7H3RlgEj65pz16m2ADj+wQpSLrqcg0AwWTRzoQ00Fd8RNvPfqzpCHLSPKSr2Ri2DQVNYUA/BvgXGP8/Q/+JOdG7FETjSDd3afvbhJQt0pF2FZytWwjXZSX7mC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Op8YMp9L; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-466897883dcso15322171cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732566775; x=1733171575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjY+Fq28smnHxNVgx2xkhej5EXhlkMnIB/YCuVo3TqU=;
        b=Op8YMp9LvZkvQ331y4bCyUoMgneAK4i5u+jBCunnzEJlJtW7xclLb5OohO9SumbGuH
         4fzagqywBItP63EQEvhmEan7XlTD5/JleLrJRmTaipMburMKxgd/YCJCMM9/L2QEziD4
         HpOESiJdHYHgYEXEH/kBHz/lU0l52b9JAspQISBhmCNIKHWwXvoMMqQk/DicZHoejCO5
         zQXsb2cRo2wenRwFqtlgKSG3rep6fHGdD1vCpHNf8gPmWmVWyDyeN2BwPaq4dXAlmODk
         nF0UE/M1NPDRwd0oySNSQRelrxTjCRJLsMjSVAg0dONu1dA4RW6vchF8OyK6zA0iEuk8
         hCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732566775; x=1733171575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjY+Fq28smnHxNVgx2xkhej5EXhlkMnIB/YCuVo3TqU=;
        b=AVjYV8nWfaznFuLbgbUXIZ0iSMxoeDeZqev9ZvmSvRIH/kH+Ge5X7WCuWVA6Tx/T09
         9tkXggaZsLud0/DryZnBVnalqnC6F+A3qx2ltDc6bAZf8XzUlyC64T017q+a2s2ScdHY
         p/4K4Ns9siiRdOuGN8wZK5n/UJsSELlQsevJxguKxAtcP6Rsyjf4OoHwcKG0QhzbR3hF
         tIp4qWGqX6DOjuXU0Cu1NSwyAis3Ii+yvKIH98y/SlglLrPJFOmDSp1ZL75/ID83Evqg
         MZHOGI41UTyssTkpEvmLMOo2FLN2gPSx6ag/pOBPM5KUajvYE7Es97dZxseiPJPS5We0
         DHqw==
X-Forwarded-Encrypted: i=1; AJvYcCVVMsIBAqUAJIPkLQ2U5sjNeNreGbsthPLGwpD7OOBOi24ypY/eP7UrfXP7m2igeY3Uac5NKGs4a6NHTh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1Q7iuHQ3lLopVKVRDqQIjdQOjIUxUNhNxB4bfaPKSDtldzEz
	NFOe0vxlUAsitgvcxSMrl+a6T/dPT+gegpPl0M5YlltSPdDBr8m1nu2WKyD4NXc=
X-Gm-Gg: ASbGnct8cNm7CG0cQ5S9ExMZTkfqtmlFnt+U1c1GytzkwiZ3um3pyVpClCPJGAc0/Ok
	YVvytOg/lw9qR8gwarH5feCfiZc9RtVYhKEq62SEMtxpK7E2S6+nfYOxCfa/ox+x5hidXOir07O
	QUkWlVQXAh1Cbgp+YzIcloJYwxDdAIl885oGTVi9nX48tdFrC0D4v8MVDic9On156IYgHEBu9Yr
	hJo5MqCj/MuNbk65w+CC5Sx/Q8kokyfwoGhFEcX6iIKUTIOAyl/YGSLWQJPYtw/anwrXc7VCsyF
	ynhjWFwdbX/kwn0AFg==
X-Google-Smtp-Source: AGHT+IEW9gv2vT6TO3UrG3Mp0xF4g8i0ni2R6v2YWMJWAyLYNClNECvhkPWXuRBlO5lRIOzWoGjeVw==
X-Received: by 2002:a05:622a:190a:b0:461:3653:54f with SMTP id d75a77b69052e-4653d538d6fmr215091451cf.11.1732566775491;
        Mon, 25 Nov 2024 12:32:55 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466a43545besm1887821cf.83.2024.11.25.12.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:32:54 -0800 (PST)
Message-ID: <23038c4b-9f9d-4a47-8c28-89893027322f@baylibre.com>
Date: Mon, 25 Nov 2024 15:32:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: adc: ad4695: fix buffered read, single sample
 timings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
 <20241113-tgamblin-ad4695_improvements-v2-1-b6bb7c758fc4@baylibre.com>
 <20241124125206.1ffd6e6c@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241124125206.1ffd6e6c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-24 07:52, Jonathan Cameron wrote:
> On Wed, 13 Nov 2024 15:52:58 -0500
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> Modify ad4695_buffer_preenable() by adding an extra SPI transfer after
>> each data read to help ensure that the timing requirement between the
>> last SCLK rising edge and the next CNV rising edge is met. This requires
>> a restructure of the buf_read_xfer array in ad4695_state. Also define
>> AD4695_T_SCK_CNV_DELAY_NS to use for each added transfer. Without this
>> change it is possible for the data to become corrupted on sequential
>> buffered reads due to the device not properly exiting conversion mode.
>>
>> Similarly, make adjustments to ad4695_read_one_sample() so that timings
>> are respected, and clean up the function slightly in the process.
>>
>> Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
>> Co-developed-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
> Applied to the fixes-togreg branch of iio.git. I'll rebase that
> and send out a pull shortly after rc1.
>
> The other two will have to wait for that to cycle around to be
> in the upstream for my togreg branch later in the cycle.
>
> Thanks,
>
> Jonathan
Thank you!

