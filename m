Return-Path: <linux-kernel+bounces-252394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A093128A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0061C226E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110A18411C;
	Mon, 15 Jul 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="IQqpe6FN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovj4WMiq"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD513D8B1;
	Mon, 15 Jul 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040334; cv=none; b=ZJXKFCDYA4i1ypHPF60ZbqEeaARhy7sy2ZolCtyvYtc+uBBBzqsF1Dtq8h8z+OfJlGfbjRjJmzMgxrWH+BxKhsZlROotesT2aGGUzx+6BOTTphJLY7UoBZ5Q5U4erBbo1tn0RoQuyiX+YGtWmk4xR2MCVyx2t2M3TtwT+zlfXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040334; c=relaxed/simple;
	bh=qQlL9NerRG6EwyQRrrQYcG+ctKUoF3VhlKn7BJzqPpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkgyYlf9VqWamrcBFJx46aKvEMdUu9XpTZUz/xa6lbQUhooyLHJR5WCoo1n3WfXqaub2AN03xb2S3WOEQfptZWk6aclPWBHPB9q6D4TKxt8UiOhOzosE3L81AdK6DO5K5DAEUE/Pz9cN8TztV8D+iBciQM0Bo4oDAk6P5q816ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=IQqpe6FN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovj4WMiq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ABBC311481F0;
	Mon, 15 Jul 2024 06:45:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 06:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1721040331; x=1721126731; bh=56ZWuzTw6mJbwllZOtLBwU6JTqdPW3NQ
	BCrpb7kEiRs=; b=IQqpe6FNLtA2uvVNws2kDPWIhfuMqI70uZGJO5AEAeRzRTwB
	g8ZRR1v45qEl1DRAldCYwP9Kt/ESBTdwuULESDYycXNvR9u+yhY+cr/GWCWpRC8l
	Ezpdt5Hi6HEYVc9m6ILcQYOLqqqDcVu2cCDouOfW9NNt+FUOrLVRwzcBtWQXdBJH
	k4ZTttiJ4zuUbS1O3Intu43Fk2tWUIVdnYJlCQe1HkDJYCjIBTv+yqP+qDtNSmLK
	RNrbXNl8EZlt303SBQ8NMtFRzCY8/vWX1In9+Rc8BDbyLtuViqzq09wPvimJ2Ez7
	1IZC7cxiduFMnCEB3VZw39yMtZq3GBPm7jyAcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1721040331; x=1721126731; bh=56ZWuzTw6mJbw
	llZOtLBwU6JTqdPW3NQBCrpb7kEiRs=; b=ovj4WMiqirXRxY4y31TkTuFlhdDCy
	nVcFrpOMOZf3rXcsfmUFr6SH0cL3yQovGWlpc1ifzjXyyyJmE9uULqxVmE/P9BG/
	o/JLuaZkbH1fUN+D5o122EIuEIfhnJaUi/nSI8dKdB7kEOFwdXWlI0Gtru4Vu35X
	IFQAW3e+Iauxr2hM6chSPBbzZ//4EWEWPXUYzutLkviwSJbozII6sDMwsV5ka7dL
	7nL3P9wOOeE52gsUv3Em5uPU60aEOoR61PpwrxkUrsjZcS+RjPdW6bgZS5K+wFnh
	M7dP9bNiqYAYYqjrGmgprfLICFyrrk8oNBbZwXHuwBqimQWrFDhDQf99w==
X-ME-Sender: <xms:yv2UZuo0uQL9qLlmbU3rGIYQFk6p0sAT-XSmrxpHT_1NnGISIX9E5w>
    <xme:yv2UZsrfE4rQxCme-cOFhaqz39VTL1uqhgQ2M26BB-F4_FvTpSa1CO7hLQpBEflo5
    NGXtnFMrHGskg>
X-ME-Received: <xmr:yv2UZjMdHhcoUjEwwuGNuoqHsT5kABeobVGvQL3HRx2X53feGmCbeD4nqRe-_m3u3nepkTnCTW_3Uq7QhdBTY9S8FffpcHycmZKTYlhn3lJm0CkHTHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepleekhfdu
    leetleelleetteevfeefteffkeetteejheelgfegkeelgeehhfdthedvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:yv2UZt6s9U_rKO4fOHs1zVzOzClhuLSb6MqGodQ_2XgoDTNuL5kgng>
    <xmx:yv2UZt7S1eEoDXDV6hR0Orkgx8FyaXoChBqwEBYkAeAmXVnnX0yXhg>
    <xmx:yv2UZtjYDK2fdlLqMSSIR_MFZgOd1LBAk0g8QIJFAC-uhUMIme0Gfw>
    <xmx:yv2UZn71B-OEMsqYfyynO04KcHYOoeIDl6e7jUrqiPFxAG7TyMeEHA>
    <xmx:y_2UZg12p0dGd1XGfbCN79toXRV56tUPeX7_b4Yhoyi06NYpYy_mgTjJ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 06:45:29 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org (open list:USB SERIAL SUBSYSTEM)
Subject: [PATCH] USB: serial: Change usb_debug to not echo by default
Date: Mon, 15 Jul 2024 12:44:53 +0200
Message-ID: <20240715104456.1814444-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver is intended as a "client" end of the console connection.
When connected to a host it's supposed to receive debug logs, and
possibly allow to interact with whatever debug console is available
there. Feeding messages back, depending on a configuration may cause log
messages be executed as shell commands (which can be really bad if one
is unlucky, imagine a log message like "prevented running `rm -rf
/home`"). In case of Xen, it exposes sysrq-like debug interface, and
feeding it its own logs will pretty quickly hit 'R' for "instant
reboot".

Contrary to a classic serial console, the USB one cannot be configured
ahead of time, as the device shows up only when target OS is up. And at
the time device is opened to execute relevant ioctl, it's already too
late, especially when logs start flowing shortly after device is
initialized.
Avoid the issue by changing default to no echo for this type of devices.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/usb/serial/usb_debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
index 6934970f180d..91150c050637 100644
--- a/drivers/usb/serial/usb_debug.c
+++ b/drivers/usb/serial/usb_debug.c
@@ -76,6 +76,11 @@ static void usb_debug_process_read_urb(struct urb *urb)
 	usb_serial_generic_process_read_urb(urb);
 }
 
+static void usb_debug_init_termios(struct tty_struct *tty)
+{
+	tty->termios.c_lflag &= ~ECHO;
+}
+
 static struct usb_serial_driver debug_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -86,6 +91,7 @@ static struct usb_serial_driver debug_device = {
 	.bulk_out_size =	USB_DEBUG_MAX_PACKET_SIZE,
 	.break_ctl =		usb_debug_break_ctl,
 	.process_read_urb =	usb_debug_process_read_urb,
+	.init_termios =		usb_debug_init_termios,
 };
 
 static struct usb_serial_driver dbc_device = {
@@ -97,6 +103,7 @@ static struct usb_serial_driver dbc_device = {
 	.num_ports =		1,
 	.break_ctl =		usb_debug_break_ctl,
 	.process_read_urb =	usb_debug_process_read_urb,
+	.init_termios =		usb_debug_init_termios,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-- 
2.44.0


