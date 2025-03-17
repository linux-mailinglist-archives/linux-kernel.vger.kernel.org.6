Return-Path: <linux-kernel+bounces-563442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEECBA641E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609077A3CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B44219A8D;
	Mon, 17 Mar 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JUhC/VS/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A17219E8F;
	Mon, 17 Mar 2025 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193659; cv=none; b=X7n/E4IimcJ/qaiD6nJE9JhbkQOyB7XFunlkXNFQLWy8eJ82x3UjQuqYYGF4AHi0JML06z2XQ1BsWX2ChR9mqqQirTKv7kgUlxXICzETQaxoFSns9qmZOjbjjcfQOdd6F+nqIlRNRSTyk5jqnjdLNf4XfFafP9NH9jdsYq4Vt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193659; c=relaxed/simple;
	bh=ueTDnhNiGkK2trcg7SlaETXX/t3eit7F2ZXxKu4qBeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiPW3wsJ02DQcOVJpDFuhVEMXG3QkBiNBsgpkuDnIzqtn3sl2VEQZ/tuxVaoRdCjZUc+oNNlkjhQwNcDu4QIaNXYODtuuIYcciB3HjqM3V57gQkXIwaZuCWxJz2L4DC9k8q0QLoHXvzZW1qq3MhPLlE789Q9qqOh7+JHp/ZHGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JUhC/VS/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742193652;
	bh=ueTDnhNiGkK2trcg7SlaETXX/t3eit7F2ZXxKu4qBeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUhC/VS/2iR6e0Ge8EuxwPO8sNgvrpJWuqLplCWY8qYpZ6U+SVBpRzfIfq554rzrW
	 A2v/ONO39sMbG8pvWOADVeiwh2xBcqFaQSLgZI8HA6jdq1di4101Ys/JMpwqsIS6Ob
	 ERK+FZreU2n7p0+zG4BQ3o52xyLWX9se0wES8bLs=
Date: Mon, 17 Mar 2025 07:40:51 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: "Sung-Chi, Li" <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
Message-ID: <f6b09d06-6fc5-4032-a960-856e8cbd1574@t-8ch.de>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
 <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>
 <Z9ecN4ZWx1P5csrK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9ecN4ZWx1P5csrK@google.com>

On 2025-03-17 11:51:19+0800, Sung-Chi, Li wrote:
> On Thu, Mar 13, 2025 at 05:24:28PM +0100, Thomas Weißschuh wrote:
> > On 2025-03-13 12:47:43+0800, Sung-Chi Li wrote:
> > > Implement the functionality of reading the target fan RPM setting from
> > > ChromeOS embedded controller under framework.
> > > 
> > > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > > ---
> > >  drivers/hwmon/cros_ec_hwmon.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> > > index b2fec0768301f116f49c57b8dbfb042b98a573e1..73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3 100644
> > > --- a/drivers/hwmon/cros_ec_hwmon.c
> > > +++ b/drivers/hwmon/cros_ec_hwmon.c
> > > @@ -36,6 +36,19 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
> > >  	return 0;
> > >  }
> > >  
> > > +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)
> > 
> > int32_t is a userspace type. In the kernel use i32, or even better u32.
> > 
> Sorry for missing this important detail, I will not use userspace type
> for following changes.

No need to be sorry.

<snip>

> > > +
> > > +	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0, &r, sizeof(r));
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*speed = le32_to_cpu(r.rpm);
> > 
> > r.rpm is not marked as __le32, I'm not sure if sparse will complain
> > about the usage of le32_to_cpu().
> > 
> It did. Currently, all devices are running little endians on both AP and EC, so
> I think it is ok not to explicitly call the le32_to_cpu?

I think on big endian none of the CrOS EC code in Linux would work.
But as the driver currently already uses leXX_to_cpu() it would be nice
to keep using it consistently.
The nicest solution would be to change the definition of
struct ec_response_pwm_get_fan_rpm to use __le32.
Or add a cast: le32_to_cpu((__force __le32)r.rpm);

