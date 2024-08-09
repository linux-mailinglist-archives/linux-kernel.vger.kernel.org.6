Return-Path: <linux-kernel+bounces-280491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F194CB4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C76284E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C2178378;
	Fri,  9 Aug 2024 07:26:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FD17BA2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188360; cv=none; b=VAhyLnVx++gGwkfZNCYpTASsRBpT9HhvuOKS3DSfr8fRMIFYlfboA6KDypWBZYajl+c4zeaccHoS5hHejtuS7UR2FKt9+ObQ4W4TZma1so4TFrGbcU/nc8BzIoo/cP527GdFI5hfCBUuBpeTd193MPNzKgSBXhx0SgIEdNy1sJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188360; c=relaxed/simple;
	bh=yi4K1zGpJxAsjqqbdwucKt8vGdkCSnyK1MOiAV9eM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxW6DxcAeWz4kDHQJoCBlSdv5CptMpf8F6qqYQmT3FoTNXLi3UUdNYtiIEUwfRdu8ggVI2m7zkZwDFcx4ggbDqJ4euYkJZ4JcmuQd7uovJnWVs5ngm/OMdfw8nnLnRxlhGfgwgjQ56/54eeGwfQthc34EshkxRC4l1QCo8dgsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1scJl7-00012d-Vp; Fri, 09 Aug 2024 09:09:58 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1scJl2-005bez-0o; Fri, 09 Aug 2024 09:09:52 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1scJl1-00Aiml-2s;
	Fri, 09 Aug 2024 09:09:51 +0200
Date: Fri, 9 Aug 2024 09:09:51 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v6 5/5] firmware: imx: adds miscdev
Message-ID: <ZrXAv79KFCSyB3U_@pengutronix.de>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-5-ee26a87b824a@nxp.com>
 <Zp-8MPdWdAhGG9de@pengutronix.de>
 <AM9PR04MB860410277C8329271E12963F95B92@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB860410277C8329271E12963F95B92@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2024 at 10:49:33AM +0000, Pankaj Gupta wrote:
> > > +     if (tx_msg->header.tag != priv->cmd_tag) {
> > > +             err = -EINVAL;
> > > +             goto exit;
> > > +     }
> > > +
> > > +     guard(mutex)(&priv->se_if_cmd_lock);
> > > +     priv->waiting_rsp_dev = dev_ctx;
> > > +     dev_ctx->temp_resp_size = cmd_snd_rcv_rsp_info.rx_buf_sz;
> > > +
> > > +     /* Device Context that is assigned to be a
> > > +      * FW's command receiver, has pre-allocated buffer.
> > > +      */
> > > +     if (dev_ctx != priv->cmd_receiver_dev)
> > > +             dev_ctx->temp_resp = rx_msg;
> > > +
> > > +     err = ele_miscdev_msg_send(dev_ctx,
> > > +                                tx_msg,
> > > +                                cmd_snd_rcv_rsp_info.tx_buf_sz);
> > > +     if (err < 0)
> > > +             goto exit;
> > > +
> > > +     cmd_snd_rcv_rsp_info.tx_buf_sz = err;
> > > +
> > > +     err = ele_miscdev_msg_rcv(dev_ctx,
> > > +                               cmd_snd_rcv_rsp_info.rx_buf,
> > > +                               cmd_snd_rcv_rsp_info.rx_buf_sz);
> > 
> > Ok, here you now have serialized sending and receiving messages,
> > 
> > With this you no longer need priv->waiting_rsp_dev, dev_ctx->temp_resp and
> > dev_ctx->temp_resp_size. Drop these for further cleanup.
> 
> It is very much needed.
> - priv->waiting_rsp_dev, help identify in the callback function that:
> 	- the message is targeted for dev_ctx(user space) or dev(kernel space).
> 	- the message is targeted for for which dev_ctx.
> - dev_ctx->temp_resp, this buffer pointer is needed, to receive the message received in call back.
> - dev_ctx->temp_resp_size, is needed to compare the size of in-coming message.
> 
> All the three are needed in callback function.

I think you should throw away ele_miscdev_msg_send() and
ele_miscdev_msg_rcv() and instead use ele_msg_send_rcv() instead.

This driver contains a whole lot of unneeded complexity up to the point
where it's not clear what this driver is actually trying to archieve.

Please let's do a step back and try to find out the actual usecases.

What I have found out so far is:

1) We can send one message to the ELE and each message is expected to get
   one response from the ELE.
2) We are not allowed to send another message to the ELE while there is a
   message in flight that hasn't got a response.
3) Both Kernel and userspace shall be able to send commands and receive
   its responses.
4) The ELE is able to send a command itself. Is this true? Does this
   command need a response? Can we continue sending commands to the ELE
   while the ELE waits for the response to the command?


1) and 2) is covered by ele_msg_send_rcv(). 3) is covered by
ele_msg_send_rcv() as well, it can be called directly by kernel
code or via an ioctl from userspace.

4) is the most unclear point for me, but 1) 2) and 3) seems straight
forward and should be solvable with significantly reduced code size.

Am I missing any features that you need as well?


> 
> > 
> > > +}
> > > +
> > > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > > +                             u64 arg) {
> > > +     struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
> > > +     struct se_if_node_info *if_node_info;
> > > +     struct se_ioctl_get_if_info info;
> > > +     int err = 0;
> > > +
> > > +     if_node_info = (struct se_if_node_info *)priv->info;
> > > +
> > > +     info.se_if_id = if_node_info->se_if_id;
> > > +     info.interrupt_idx = 0;
> > > +     info.tz = 0;
> > > +     info.did = if_node_info->se_if_did;
> > > +     info.cmd_tag = if_node_info->cmd_tag;
> > > +     info.rsp_tag = if_node_info->rsp_tag;
> > > +     info.success_tag = if_node_info->success_tag;
> > > +     info.base_api_ver = if_node_info->base_api_ver;
> > > +     info.fw_api_ver = if_node_info->fw_api_ver;
> > 
> > This really shouldn't be here. You pass cmd_tag and rsp_tag to userspace just
> > to guide userspace how to construct a message.
> > 
> > This shows that the messages should be constructed in the Kernel rather than
> > in userspace. Just pass the message content from userspace to the kernel and
> > let the kernel build the message on the sender side.
> 
> This will help collecting user-space application logs, with correct tags.
> This is already used by the customers, for debug.

I don't bother that you provide this information to userspace. My point
is that it shouldn't be needed by userspace to assemble the packets that
are sent back to the kernel.

Really the packet encapsulation should be done in the kernel and
userspace shouldn't be bothered with it.

> 
> > 
> > > +/* IOCTL entry point of a character device */ static long
> > > +se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
> > > +     struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> > > +                                                     struct se_if_device_ctx,
> > > +                                                     miscdev);
> > > +     struct se_if_priv *se_if_priv = dev_ctx->priv;
> > > +     int err = -EINVAL;
> > > +
> > > +     /* Prevent race during change of device context */
> > > +     if (down_interruptible(&dev_ctx->fops_lock))
> > > +             return -EBUSY;
> > > +
> > > +     switch (cmd) {
> > > +     case SE_IOCTL_ENABLE_CMD_RCV:
> > > +             if (!se_if_priv->cmd_receiver_dev) {
> > > +                     err = 0;
> > > +                     se_if_priv->cmd_receiver_dev = dev_ctx;
> > > +                     dev_ctx->temp_resp = kzalloc(MAX_NVM_MSG_LEN,
> > GFP_KERNEL);
> > > +                     if (!dev_ctx->temp_resp)
> > > +                             err = -ENOMEM;
> > > +             }
> > 
> > cmd_receiver_dev isn't locked by anything, still it can be accessed by different
> > userspace processes.
> 
> It is not accessed by different Userspace processes. It is a slave to FW.
> FW interacts with it when FW receive a command to do any action, from userspace.
> Hence, it will be executed under command-lock.

When two userspace programs have a device instance open, then nothing
prevents them from calling this ioctl at the same time. You do a

	if (!se_if_priv->cmd_receiver_dev)
		se_if_priv->cmd_receiver_dev = dev_ctx;

which is executed by two threads simultaneously. It's one of the most
classic scenarios that need locking.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

