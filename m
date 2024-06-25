Return-Path: <linux-kernel+bounces-229330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA62F916E67
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F2B1F22CED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F53176ABC;
	Tue, 25 Jun 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKjk20om"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798517623D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334166; cv=none; b=LJycb6hVHrXi8xP8uA4BKVgtewA3tHu9YCxIGqr7+Hiia1/++Gqnp/JmLiG9gubm29YoUPZy76yL2xjtPwYGQBW2drANB545vbSY98xVimw3TYlcZS1dSbCVIqESrNbzfkYf8ThMDc1M0Dll1W3qOeRw/ygx3lSqauMZ0deTO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334166; c=relaxed/simple;
	bh=7WBwALYGkHe0OssGLzpAe2cOmIQOzyhvr2ZnXwTvXk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+EEr3HsXKp2b4/W1rmky48T4SbhM1PKv/FNG9uLtDkxw0V0KVtkeyGP+H4Z4NqvEVwif38UQIYsriDNTsA/HIOvR57u5mkW4WK35t+Fl4dSQUn5fSZNbEQNYh684qLp39p2tLBwN/6V9lSRd7yaUwm31MM3UsjCzhy/N4Yat2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKjk20om; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec58040f39so33624571fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719334163; x=1719938963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=REeWtAXLQdcK06O/ssyhbDKxgCQp9yFMmFuJINFQnRo=;
        b=SKjk20omnXu1uC5jOaAaJx8rINLqi03Hl3X1vhuO8w5H0dNCzYZUn/WN/RnEsLVJbu
         GnioiixttApQghhFxwhl12qZd+GZDQa6JWm2vkX3yUehX5WpiaqzMN+BN16v1VcGN+dl
         uXmcwKWdQ0beXRCo7fpxA3OJnGKn8HcUoMK2w8AFd/vme1A7rpvJDEz2Pw/Ze/lbt7Ud
         6zjZp3cJxRqYUc+Y/A2QGH4ohVF7+J5jzCcwYdxS+atkHX/II/6ixi+uLrmcpTVLtm/K
         TTRHBNPec5YQ8A2iSWtGi5USbhNhNbcj14PQqMCPPg268U0EY7PKnXsnADelKSi8lhwf
         bmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334163; x=1719938963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REeWtAXLQdcK06O/ssyhbDKxgCQp9yFMmFuJINFQnRo=;
        b=qvJbzbTlX6Q5crN5j6ID7fSpZ23f1iT7XGPY9WtShXtNHh8y89uPz721O/kFwIEewj
         lh/AYgGP4bSYeDKTzYLYqV6n699tmckpHrDrSTlFmkHLCortJOh9+rFd/uMnjMvCrlmI
         9ZSs3eDUtdCEYk0SLBacm49J5bpOogz8GaPEyfGdyXrvSAr29IW4LiU1wmUrwQ9qopVm
         7vqUPYK44Ij29y4OxkDKXi7e8tj6xUWTDH3uVsJrGWAOjBWOQoctU6zlPtPdfsEv+sKq
         nx/2j9OOSwZZOEdlH6GAecTe569u0pJ4lElDeJfO70Wd0lHsP/Y2bsnfAVWeHBDmEiwL
         D6kA==
X-Forwarded-Encrypted: i=1; AJvYcCVdq9I78RZfkVDsR5VFQSnCdyU8+48jIlLlH8lWUkyApyfJLDXnFlx3j+3UOI+b845L4z+x/WAJ0vVQdx/uKGJ+MD9omRMhGVU1j9eK
X-Gm-Message-State: AOJu0YweUeYw/V6SvVi3R/FSqw72I2orVoTFoMOBax3JT9NqYDgQ+QLY
	8se21fJT2yu3jyDeGROcCuAQoIqwuaURp2k2OYWeKvKzIrGKyj057dccSLlI0xKKUTX1aZFMzua
	YbfI=
X-Google-Smtp-Source: AGHT+IGBuyLNjCbPQ995hC2wMffXdWuFAcAmTyiJzKbmrMEfh5HoCsgV31k/cina59eUth0JJHY0LA==
X-Received: by 2002:a05:6512:46f:b0:52c:9f9e:d8e3 with SMTP id 2adb3069b0e04-52ce064e3d8mr5205362e87.31.1719334160965;
        Tue, 25 Jun 2024 09:49:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b49e7sm1283003e87.34.2024.06.25.09.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:49:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:49:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [Linux-stm32] [PATCH v2 6/7] usb: typec: ucsi: extract common
 code for command handling
Message-ID: <k2q7g6ka34o2vgoy5s64nwixqa6qjaok72fuxgircwseyn2k7z@pm56aurq42n6>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
 <20240621-ucsi-rework-interface-v2-6-a399ff96bf88@linaro.org>
 <160e7af5-29c8-49a6-ae4f-dbfc3dd608c1@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160e7af5-29c8-49a6-ae4f-dbfc3dd608c1@foss.st.com>

On Tue, Jun 25, 2024 at 05:24:54PM GMT, Fabrice Gasnier wrote:
> On 6/21/24 00:55, Dmitry Baryshkov wrote:
> > Extract common functions to handle command sending and to handle events
> > from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
> > the same way.
> > 
> > The CCG driver used DEV_CMD_PENDING both for internal
> > firmware-related commands and for UCSI control handling. Leave the
> > former use case intact.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c           | 43 +++++++++++++++++++++++++++
> >  drivers/usb/typec/ucsi/ucsi.h           |  7 +++++
> >  drivers/usb/typec/ucsi/ucsi_acpi.c      | 46 ++---------------------------
> >  drivers/usb/typec/ucsi/ucsi_ccg.c       | 21 ++-----------
> >  drivers/usb/typec/ucsi/ucsi_glink.c     | 47 ++---------------------------
> >  drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 44 ++--------------------------
> >  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 ++-------------------------------
> >  7 files changed, 62 insertions(+), 198 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index 4ba22323dbf9..691ee0c4ef87 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -36,6 +36,48 @@
> >   */
> >  #define UCSI_SWAP_TIMEOUT_MS	5000
> >  
> > +void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> > +{
> > +	if (UCSI_CCI_CONNECTOR(cci))
> > +		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> > +
> > +	if (cci & UCSI_CCI_ACK_COMPLETE &&
> > +	    test_bit(ACK_PENDING, &ucsi->flags))
> > +		complete(&ucsi->complete);
> > +
> > +	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> > +	    test_bit(COMMAND_PENDING, &ucsi->flags))
> > +		complete(&ucsi->complete);
> 
> Hi Dmitry,
> 
> I've recently faced some race with ucsi_stm32g0 driver, and have sent a
> fix for it [1], as you've noticed in the cover letter.
> 
> To fix that, I've used test_and_clear_bit() in above two cases, instead
> of test_bit().

Could you possible describe, why do you need test_and_clear_bit()
instead of just test_bit()? The bits are cleared at the end of the
.sync_write(), also there can be no other command (or ACK_CC) submission
before this one is fully processed.

> 
> https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> 
> > +}
> > +EXPORT_SYMBOL_GPL(ucsi_notify_common);
> > +
> > +int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
> > +{
> > +	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
> > +	int ret;
> > +
> > +	if (ack)
> > +		set_bit(ACK_PENDING, &ucsi->flags);
> > +	else
> > +		set_bit(COMMAND_PENDING, &ucsi->flags);
> > +
> > +	ret = ucsi->ops->async_control(ucsi, command);
> > +	if (ret)
> > +		goto out_clear_bit;
> > +
> > +	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
> > +		ret = -ETIMEDOUT;
> 
> With test_and_clear_bit(), could return 0, in case of success here.

Oh, I see. So your code returns earlier. I have a feeling that this
approach is less logical and slightly harder to follow.

Maybe it's easier if it is implemented as:

if (wait_for_completion_timeout(...))
	return 0;

if (ack)
	clear_bit(ACK_PENDING)
else
	clear_bit(COMMAND_PENDING)

return -ETIMEDOUT;


OR

if (!wait_for_completion_timeout(...)) {
	if (ack)
		clear_bit(ACK_PENDING)
	else
		clear_bit(COMMAND_PENDING)

	return -ETIMEDOUT;
}

return 0;

But really, unless there is an actual issue with the current code, I'd
prefer to keep it. It makes it clear that the bits are set and then are
cleared properly.

> I'd suggest to use similar approach here, unless you see some drawback?
> 
> Best Regards,
> Fabrice
> 
> > +
> > +out_clear_bit:
> > +	if (ack)
> > +		clear_bit(ACK_PENDING, &ucsi->flags);
> > +	else
> > +		clear_bit(COMMAND_PENDING, &ucsi->flags);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
> > +
> >  static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
> >  {
> >  	u64 ctrl;
> > @@ -1883,6 +1925,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
> >  	INIT_WORK(&ucsi->resume_work, ucsi_resume_work);
> >  	INIT_DELAYED_WORK(&ucsi->work, ucsi_init_work);
> >  	mutex_init(&ucsi->ppm_lock);
> > +	init_completion(&ucsi->complete);
> >  	ucsi->dev = dev;
> >  	ucsi->ops = ops;
> 
> [snip]
> 
> >  	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
> > diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> > index 14737ca3724c..d948c3f579e1 100644
> > --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> > +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> > @@ -61,11 +61,7 @@ struct ucsi_stm32g0 {
> 
> [snip]
> 
> > -
> > -	ret = ucsi_stm32g0_async_control(ucsi, command);
> > -	if (ret)
> > -		goto out_clear_bit;
> > -
> > -	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
> > -		ret = -ETIMEDOUT;
> > -	else
> > -		return 0;
> > -
> > -out_clear_bit:
> > -	if (ack)
> > -		clear_bit(ACK_PENDING, &g0->flags);
> > -	else
> > -		clear_bit(COMMAND_PENDING, &g0->flags);
> > -
> > -	return ret;
> > -}
> > -
> >  static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
> >  {
> >  	struct ucsi_stm32g0 *g0 = data;
> > @@ -449,13 +416,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
> >  	if (ret)
> >  		return IRQ_NONE;
> >  
> > -	if (UCSI_CCI_CONNECTOR(cci))
> > -		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
> > -
> > -	if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
> > -		complete(&g0->complete);
> > -	if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
> > -		complete(&g0->complete);
> > +	ucsi_notify_common(g0->ucsi, cci);
> 
> I can see the fix "test_and_clear_bit()" sent earlier is removed from here.
> 
> I'd suggest to use similar approach as here, unless you see some drawback?
> 
> Please advise,
> Best Regards,
> Fabrice

-- 
With best wishes
Dmitry

