Return-Path: <linux-kernel+bounces-380590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80D9AF30F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24108B2374F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1A52170B9;
	Thu, 24 Oct 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="O9tZyUp+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9+icZze"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A91E571C;
	Thu, 24 Oct 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799752; cv=none; b=u+XQONfk9cGaUczKi2CPFktbOEKMzf/DJWCjLoQ0GrJJxfUEJTlRe1LuH4WADsqKO4L6VkXorj3VqVdOQ4RtPW7NqG0M5VMjlaHdOfz/xJeOIdVgPDu9cvlPMI3Ng6UPg2vFeymCDvuwoHdTXOY3t0wJlgWQhAz7VvSoBQkMcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799752; c=relaxed/simple;
	bh=vBt/wQtGBvwpSFgVvRBNIc6vXaA9Z6ZAlUdY9IcLcbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRj4cDrY8C6uuqINwW//dCrD00iJSLCWgXtgPkoLB8Wn8tq9nJ/1GFeT24jYTTF1GaheVsdpzQZ9ccodjBipqcszjeRYSjUgL9sCX5l6wvjMKiTYyuoprfkIxH5oJDkJXtuhgNrHSPAZDZG4S5BXMDvDmSFtA08ChILWxgH1FEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=O9tZyUp+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9+icZze; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 6418513802D7;
	Thu, 24 Oct 2024 15:55:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 24 Oct 2024 15:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729799748; x=
	1729886148; bh=Ab0SnLoKjbhnLVZwanUlTXBcVcQz3O7pKWVotluk6Ts=; b=O
	9tZyUp+KHCZG+80uY3S8LGvKUm8U9h2iujyGlTdKYB5GcU2CguBzlEQ/5anwvoDg
	VOCBnaBXE65zQ8uXQGb6OeqxRAdqQ8GwDj61vRK44KqVP5Bj36fbuZGPeDvsXCi3
	k7MF/06D51XxcbdcRb9vWG1hGcMQqMdJztiIhdk7ovOc+DgjSouZgxPjPG6PSTsV
	Kz0VANI2VemFVqTZoGlXIqldHxPjZvUe4M7s53tooT7Akk0yOwrop4qU0I1GL5QN
	CUTE6E1YQ3Xe1d22q+pDV8CAmN+XyvB8c+8VZVZtRjcWDOr5IH8GFiCxhhGVBL2N
	JQjKHz/9z4BYmzHkJqAyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729799748; x=
	1729886148; bh=Ab0SnLoKjbhnLVZwanUlTXBcVcQz3O7pKWVotluk6Ts=; b=V
	9+icZzeG9Acf+zF8QgBCYHPccPxsc90g1bPJ+UMh310osfr+umOlcqwEY/IKQoI9
	eQblzaIEQt/7xkTrJ2vNMOlUQkOdj5Yhgoar5pS+2+eWRL7SHHu259x8bVhqr6cs
	tPqyD3bn8oVNzczzihZw2YmZpmoMS2oNi481syExn0ac8E5V7pG8nuTyvZxfFd8A
	h6G2owGP/DhbJmbDRKCsu9ozmQxT8qufWneTxtT5OFPO+wZ2xF/Y3eu4qPBiD9UH
	1VTrMlEDOYkq4LcjGuQygNYISRgNFwPQSjJtxhETP95DSRBO2gZGDnjg2eNe4Q7/
	1iVtUrYVdo9J4/G3V4jbw==
X-ME-Sender: <xms:RKYaZ7xGO-o__3bqNNmCxr8xeBGHjxEEuG8-gyIKzZ8mujWMEPm63g>
    <xme:RKYaZzQiEIKzEzAwMSROK0fIGXlQ2j9qCS0LeeNCKw49UDDDeC9HELXmX7WJB6F0Y
    3-Q56u8ktfWpUdKrwE>
X-ME-Received: <xmr:RKYaZ1Wg6XaZs5393kCTa5_wmZlzck5wdgxoap9vgYDnOrEX7efDhUJAzIZsbQtrd4lM5C0ycJPWXGiI8no2si31hhS18CQ0pM6bIPJe13QLnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduuc
    dludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peforghrkhcurfgvrghrshhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteei
    geeugfekhffhgeejudeuteehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdr
    tggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhrtghpthhtohephhgu
    vghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvih
    hnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphhlrghtfhhorhhm
    qdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RKYaZ1gOxVB7G2vzuoa9JOVTofOUGHHppnFkCjVlzwnvKK5UsFJk9g>
    <xmx:RKYaZ9DvLTTxu7wWUWyD1TeEQk1yWBaqy9c3YOQAxUCeRdcElXJYHw>
    <xmx:RKYaZ-KXqnEc9pTGftI7m_mN0ngD_GO8uw-hJtVO8pM8StyPA_KO7A>
    <xmx:RKYaZ8BIDR0Pxt0ybSJPHqPIjrTC6e-fS_wb8Bbq0thPWTvjl1gHgA>
    <xmx:RKYaZw6wNu53M5XCHFVrHo1MyB0FiI6hFe6J5vvXIMm-I-8TAyYRD1iF>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 15:55:47 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: think-lmi: Add certificate as mechanism
Date: Thu, 24 Oct 2024 15:55:22 -0400
Message-ID: <20241024195536.6992-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As both password or certificate authentication are available as mechanisms
update the documentation to add certificate as an option

Update driver to return correct mechanism appropriately.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2: No changes, version updated as part of series.

 Documentation/ABI/testing/sysfs-class-firmware-attributes | 2 +-
 drivers/platform/x86/think-lmi.c                          | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 9c82c7b42ff8..1a8b59f5d6e3 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -193,7 +193,7 @@ Description:
 
 		mechanism:
 					The means of authentication.  This attribute is mandatory.
-					Only supported type currently is "password".
+					Supported types are "password" or "certificate".
 
 		max_password_length:
 					A file that can be read to obtain the
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 727a9400d406..46ab82fb2898 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -524,6 +524,10 @@ static struct kobj_attribute auth_max_pass_length = __ATTR_RO(max_password_lengt
 static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
+	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
+
+	if (setting->cert_installed)
+		return sysfs_emit(buf, "certificate\n");
 	return sysfs_emit(buf, "password\n");
 }
 static struct kobj_attribute auth_mechanism = __ATTR_RO(mechanism);
-- 
2.47.0


