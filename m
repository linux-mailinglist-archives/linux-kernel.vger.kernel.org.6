Return-Path: <linux-kernel+bounces-355200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4F994AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52D2B25F95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2D1DC759;
	Tue,  8 Oct 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oKjB8at5"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0C1DE2A5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391083; cv=none; b=XZFwyAxHb0QzWfJwOJmWDmwPHdQPQJPyBgEypQQ6F2E3NlWEnZ5K3bOViW727+x8LR1YenAzWwhzfaih978OrfFwqrVVJzSpn5y5lLx2GWxcGbCU6Jz17+1xzKd6lwC8nBjhTce0cIL6TKFf5c3EXApYGZtfOf+onB34UupJRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391083; c=relaxed/simple;
	bh=1L+JpoFCpEvtlQx6jbzP7YtJHJrlbA6UEXXyge/5nuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vEfXdXzn5o94k+amvqXPUCNmrvREKhfomF86mANXso59MMOxWKZyk3zhXwdyfwZfg3RAAZmwjKh1UGFlDqi2Yb4KIp3FFqsDj+zB+qmj+Xmih1D7R/2cVzdoIm+rIniEeqZeu4XetBzyxFuh1/sOTLbnF6dWXMv1tANHlSU+Jps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oKjB8at5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cd3419937so3375835f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728391078; x=1728995878; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=by4sWSBDpCIFjcZGzg4X08UIZKTUMpJ+pa0NCXVeqdU=;
        b=oKjB8at5p1Ifzf8ApUugOYHNslEHFzcIvxM61VLP8GsIrCSLrbA1zqmf5yGIPpZEL4
         SOwovsxCt0XDwpFy1ZWNvLmz+PTNG+gqiK/RHHgkN/uavO4TyvQnOzkXuMz25bUPa/lT
         a8GfVUrtpcpDLkhWHS76Ae91VWEP5DB5gCueSU2cYUsN1s3guocMbMnixAxYWuJWh4Eu
         X8L47W4Xl7/MFkiqq9qmsEoHnTtp801XKFsEI7lqfYhzPwZ2Tj/4t01xioiKQFGNg2i8
         2yHogmM/nd/446Q7fnXBGHSAQr3kWJxOZexI2wPHj0gbU39qA3tEJ+6JpvuMOD45IWRD
         eUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391078; x=1728995878;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=by4sWSBDpCIFjcZGzg4X08UIZKTUMpJ+pa0NCXVeqdU=;
        b=HbiIN7cEg7bdtkEcsNgbVOnKRJIFkBGsGNHFyI8ok3g0F8eqa5bj1gErK2mD5+SpRe
         0V/fqCEs3FpvP76h+YGd+oQgxq1pxQT5aBgAxEpda/D3AMAXcb2MgNHI02+FPLQCP8Kx
         BcXst/Q/9xBnGva7wfkJpZTGKXOkdR08vsucTEQ36RMQs206JCX/ctc1miaSrOTnR++R
         /OUn7nHUk9s0H1O1WSfbqatFC8dTiC+sS2g8yTiHi4nvaKrBPFKu904ty5+A4Kp9CTiP
         9jLRf0m9IEa1BeYyNzsX/8yUZIlvEJYmNoIikqs1T9xO5cw6CD1fSc+oZfsvbPztPIAJ
         JDSA==
X-Forwarded-Encrypted: i=1; AJvYcCXw9ncec8p4PMLWVi/Uzc1vpJDyLyAKrrrjvnvuYvEC1suoxzczkZsD9Kd7OUutzWZEVIZccKzVAXWE+sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HAh78eRG7qKHRP81Q3YeWMg/GZzQr3eG4l7hZYlA0RSuCyvv
	PI8VDIbEbBmoLdDRHsAzXZ9FtOc3t/cI9m5LIuYBz+qFox06zUdIQVIOSK0hXaY=
X-Google-Smtp-Source: AGHT+IF7jLyp1F9r1R7paqLXL7lZm4mJSG2e31oTisk0Sxja0KjHZpxs+MoHEKQXr+fL0PGmbZlONQ==
X-Received: by 2002:a5d:5e0b:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-37d11311be4mr7478306f8f.26.1728391078001;
        Tue, 08 Oct 2024 05:37:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43050578facsm20299775e9.19.2024.10.08.05.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:37:57 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: neil.armstrong@linaro.org
Cc: George Stark <gnstark@salutedevices.com>,
  u.kleine-koenig@pengutronix.de,  khilman@baylibre.com,
  martin.blumenstingl@googlemail.com,  linux-pwm@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  kernel@salutedevices.com
Subject: Re: [PATCH 3/3] pwm: meson: Enable constant and polarity features
 for g12, axg, s4
In-Reply-To: <5c3a6fdb-e4f0-4a22-9a8d-84baee12769c@linaro.org> (neil
	armstrong's message of "Tue, 8 Oct 2024 09:31:09 +0200")
References: <20241007193203.1753326-1-gnstark@salutedevices.com>
	<20241007193203.1753326-4-gnstark@salutedevices.com>
	<5c3a6fdb-e4f0-4a22-9a8d-84baee12769c@linaro.org>
Date: Tue, 08 Oct 2024 14:37:56 +0200
Message-ID: <1ja5fesrbv.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 08 Oct 2024 at 09:31, neil.armstrong@linaro.org wrote:

> On 07/10/2024 21:32, George Stark wrote:
>> g12, axg and s4 SoC families support constant and polarity bits so enable
>> those features in corresponding chip data structs.
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 6701738c55e3..c6f032bdfe78 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -571,26 +571,36 @@ static const struct meson_pwm_data pwm_gxbb_ao_data = {
>>   static const struct meson_pwm_data pwm_axg_ee_data = {
>>   	.parent_names = { "xtal", "fclk_div5", "fclk_div4", "fclk_div3" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_axg_ao_data = {
>>   	.parent_names = { "xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_g12a_ee_data = {
>>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
>>   	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>>   	.parent_names = { "xtal", "g12a_ao_clk81", NULL, NULL },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_meson8_v2_data = {

This needs to be splitted and adjusted as well then.
g12 and axg are covered by pwm_meson8_v2_data.

>> @@ -599,6 +609,8 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>>     static const struct meson_pwm_data pwm_s4_data = {
>>   	.channels_init = meson_pwm_init_channels_s4,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct of_device_id meson_pwm_matches[] = {
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

-- 
Jerome

