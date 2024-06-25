Return-Path: <linux-kernel+bounces-229216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7255C916CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29239286123
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8BD171E77;
	Tue, 25 Jun 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ehy0eJlm"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F75154C18;
	Tue, 25 Jun 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329169; cv=none; b=hiXjbWNgbbDr57iYP4e7zeG9kPlgKl/U/GmKq5LoAXhk6sgl2JovxZH7Rx+AyLzeqkGfs8zN6/NstVFhXDIyeR7CFzls26l90hHLzA+6BoLlZHQmTSO8P1kdGjumgxKGY2SY2khRuj/BmseQqXQZd8N/NOw+6U9uIqEGNTqX3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329169; c=relaxed/simple;
	bh=sdfaXkV0ZRdCj960vhUIBQqa7zAxMkZ3euRIAUnaJOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V1N8PmocMVZhV9FGwkf0fcsESuf4vWoFpu4gHtcvsGxosrHl5/JpoJZb13SoWCW/RLfO04IjedebSBKvfU1/SkVuMws2jmQKNEBBDzblquywlD1+mvH6uFMM6nmgSXnEZ40esokahbOlKnDq10CW6pWaUdGX3uKyITZotU5/3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ehy0eJlm; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PCWaBS026625;
	Tue, 25 Jun 2024 17:25:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	5edzio71DzaT5lNquA9f78o6eePUxXY41XuAi046gC4=; b=ehy0eJlmIYtr75+D
	t5lfKHRXhqco67FEjoxZRxxu4q9xgtDTyVo605dSwBCoOvioEqvy7QW/ZRVEMMVY
	Q6umtClhHR8P93I4qtodN+U9uFw4Locy32XqC1Xw/8R1JCE54wN6JU9NacB/UTjG
	U9yqd7fZ4fBNWuvlEqJZ0/Q72i6MEhxBsWT/vZ9JhPD/aFk8TL5BEAI0MW4LA4cx
	UEiVUZVCFRvNlcAiH/6jfsm7aOTaS9v9Pkkr4n0Uf0sd9E/nl69qENwWoYf+JOl0
	DW3M+bHx55b6Gde7pwcxg41J6W0dkdr2wRMYxBSAqEVypfoLoFDbmXbEfQ1AbHzw
	56kVxg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywnxxcgkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:25:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7223C4002D;
	Tue, 25 Jun 2024 17:25:37 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B79A220B42;
	Tue, 25 Jun 2024 17:24:56 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:24:56 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:24:55 +0200
Message-ID: <160e7af5-29c8-49a6-ae4f-dbfc3dd608c1@foss.st.com>
Date: Tue, 25 Jun 2024 17:24:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH v2 6/7] usb: typec: ucsi: extract common
 code for command handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nikita Travkin <nikita@trvn.ru>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
 <20240621-ucsi-rework-interface-v2-6-a399ff96bf88@linaro.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20240621-ucsi-rework-interface-v2-6-a399ff96bf88@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01

On 6/21/24 00:55, Dmitry Baryshkov wrote:
> Extract common functions to handle command sending and to handle events
> from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
> the same way.
> 
> The CCG driver used DEV_CMD_PENDING both for internal
> firmware-related commands and for UCSI control handling. Leave the
> former use case intact.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c           | 43 +++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h           |  7 +++++
>  drivers/usb/typec/ucsi/ucsi_acpi.c      | 46 ++---------------------------
>  drivers/usb/typec/ucsi/ucsi_ccg.c       | 21 ++-----------
>  drivers/usb/typec/ucsi/ucsi_glink.c     | 47 ++---------------------------
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 44 ++--------------------------
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 ++-------------------------------
>  7 files changed, 62 insertions(+), 198 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 4ba22323dbf9..691ee0c4ef87 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -36,6 +36,48 @@
>   */
>  #define UCSI_SWAP_TIMEOUT_MS	5000
>  
> +void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> +{
> +	if (UCSI_CCI_CONNECTOR(cci))
> +		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> +
> +	if (cci & UCSI_CCI_ACK_COMPLETE &&
> +	    test_bit(ACK_PENDING, &ucsi->flags))
> +		complete(&ucsi->complete);
> +
> +	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> +	    test_bit(COMMAND_PENDING, &ucsi->flags))
> +		complete(&ucsi->complete);

Hi Dmitry,

I've recently faced some race with ucsi_stm32g0 driver, and have sent a
fix for it [1], as you've noticed in the cover letter.

To fix that, I've used test_and_clear_bit() in above two cases, instead
of test_bit().

https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/

> +}
> +EXPORT_SYMBOL_GPL(ucsi_notify_common);
> +
> +int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
> +{
> +	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
> +	int ret;
> +
> +	if (ack)
> +		set_bit(ACK_PENDING, &ucsi->flags);
> +	else
> +		set_bit(COMMAND_PENDING, &ucsi->flags);
> +
> +	ret = ucsi->ops->async_control(ucsi, command);
> +	if (ret)
> +		goto out_clear_bit;
> +
> +	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
> +		ret = -ETIMEDOUT;

With test_and_clear_bit(), could return 0, in case of success here.

I'd suggest to use similar approach here, unless you see some drawback?

Best Regards,
Fabrice

> +
> +out_clear_bit:
> +	if (ack)
> +		clear_bit(ACK_PENDING, &ucsi->flags);
> +	else
> +		clear_bit(COMMAND_PENDING, &ucsi->flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
> +
>  static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
>  {
>  	u64 ctrl;
> @@ -1883,6 +1925,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
>  	INIT_WORK(&ucsi->resume_work, ucsi_resume_work);
>  	INIT_DELAYED_WORK(&ucsi->work, ucsi_init_work);
>  	mutex_init(&ucsi->ppm_lock);
> +	init_completion(&ucsi->complete);
>  	ucsi->dev = dev;
>  	ucsi->ops = ops;

[snip]

>  	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index 14737ca3724c..d948c3f579e1 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -61,11 +61,7 @@ struct ucsi_stm32g0 {

[snip]

> -
> -	ret = ucsi_stm32g0_async_control(ucsi, command);
> -	if (ret)
> -		goto out_clear_bit;
> -
> -	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
> -		ret = -ETIMEDOUT;
> -	else
> -		return 0;
> -
> -out_clear_bit:
> -	if (ack)
> -		clear_bit(ACK_PENDING, &g0->flags);
> -	else
> -		clear_bit(COMMAND_PENDING, &g0->flags);
> -
> -	return ret;
> -}
> -
>  static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>  {
>  	struct ucsi_stm32g0 *g0 = data;
> @@ -449,13 +416,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>  	if (ret)
>  		return IRQ_NONE;
>  
> -	if (UCSI_CCI_CONNECTOR(cci))
> -		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
> -
> -	if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
> -		complete(&g0->complete);
> -	if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
> -		complete(&g0->complete);
> +	ucsi_notify_common(g0->ucsi, cci);

I can see the fix "test_and_clear_bit()" sent earlier is removed from here.

I'd suggest to use similar approach as here, unless you see some drawback?

Please advise,
Best Regards,
Fabrice

