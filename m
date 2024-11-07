Return-Path: <linux-kernel+bounces-399081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC29BFACF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA8E283E99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3044A2D;
	Thu,  7 Nov 2024 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="brvrDi9P"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90563C;
	Thu,  7 Nov 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939959; cv=none; b=QfZThOAWU35iV0fnbfQ0mn3rvNSVEj736UmUhHnhzE6joPBr26d29J3VILzJfB7TA45bPhMdaLqyq0wht0nND+t/cyOsZW/n6T1qWC2Wm6FfYzF0pZyWUOIrZAUEJZq3KN11/tTPXZ5ncNG6JoV1SqoRUWr/IeMPB0fUcpSwrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939959; c=relaxed/simple;
	bh=qV+QyR5vEVW16n8DtUQhTh+8NJPxqi6wOA+hItfXCcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kbzx+K4bgJONMlC8TPcGLcqTN2hRhEZiSohnxTK4yGg6NOEG1dlUGNr9Fi0VnV3dVPXD+CJCaqc3LyuIWUpWfDuVIkQJCQ2sHOeTcCiPTKhYysF/K9z55DynnTLpjiv/4My2ExwxYZI+jh+lVUwKfQsVOQa1oZ9tZM0ZGUe74LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=brvrDi9P; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730939897; x=1731544697; i=w_armin@gmx.de;
	bh=WWUSIjDCmE2YfWUklmvTiC/sg6x+DYaZ0NMPbGz2i/8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=brvrDi9Pc5ao0qU/k/r/87KwzfghqQ/zIQ/J3e96RaNNylrucE0q36809h3IOn7y
	 9/oC4gR/FQ1bs+bosfp3Rd7wxOeyu2N3YBjtq9F91aUPfRnaFMI/ki3ndpO/y8TCC
	 tV0pQ/GkIU87/oV0OCKDQnIF+G4nG2ELo6Ils9UpaDuD8Iblt6B3EdEf4l1o4CkhJ
	 eBXeXm/7oSgaCSmz8BIKRS9Sym06ayMj51eWO2Go7EUj4YsQgxVACJx4h/rGMgToV
	 ALANsJhCHX765Afeb0CqQZphnk78MgfO+281vdraqrIsHLrW7v8tWJ05OdPalNFzo
	 G3qd0i6ycva1APihog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mi2O1-1tms7E1o3N-00fx2S; Thu, 07 Nov 2024 01:38:17 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev,
	mohamed.ghanmi@supcom.tn
Cc: srinivas.pandruvada@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	Michael@phoronix.com,
	casey.g.bowman@intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix thermal profile handling
Date: Thu,  7 Nov 2024 01:38:09 +0100
Message-Id: <20241107003811.615574-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ds+V2lQhoRjZtN/zQi3ArLN2J8uxR52gA3cLdwyCXF9C5esSLpi
 M7Ix5g1Jzc0sKcaInwr6kHTVmVuffp2B0exCEhLU8fCyFsbg7bT20HRDairi51YJwU3SnGb
 9Gmqf3K+cL8mODdSskV8VCru3s/JqRPp/KEiwMuIlpTBBBREC+5xIW6gQxjQVZKtq5FQrn/
 J1+trtXxg7iElhGr4UHuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GscQi/vt+Nk=;wusmpBL2pc3a7fzlytCXxY/P4xx
 xU1eoHawrXNiWvuoQvQukn9zqGrATD6c2OkAt9DbbYhgxJF2YLN1v98Vpohd6+KG0FJeIjyYg
 9Ybnu9rbbPYn11AFteUx5QuhdZPokVSPrTMw10zs1leOQ88zBsDzatn+WcNiuwnZLzIFOcEyU
 EOhd3at6QdGb4iqh2HtY0byv7qqMMWa7FCP2gPWAQJ/357urSbUDqi9EjqjSD7GRfrYzazsoU
 4SAZTFtiMFlws/K1jkC2/cWn0uv6ulcBD3UEjTfOKk4EZ1G9w4S7tjkwbkQsad4LOZHXpy/2m
 SkWKzJgTfAY6HydI7i0+NLenprmcVhrwxTTFcbos3sefLZAYoAXmNDseCnK7rDGiBxUz1jy9D
 LQLvLTznzzXP3+Y4TGmoKSAxVFJEGqEHp0zt9Ydd2yYC/fCfyF61reit6b5Q/3NH+ZAKtQLXw
 nfzuMMDKkT42m6LEEFKmPyQxlbXB2kM5LzW+Pusxq3M9FVWs1ZLPngOE2XfSvPXarsgB7/IdW
 fd/hQBqGYxMF7sdkN3Or2l3e4tI9xM8/62e3e2MqgLah8O+NvfOI2rycKMAP4WPnPOeV74Gpt
 UlJUeEnPZzSaMZJMXwLBUUE3qff2IGJ1ePO0NHVRdRp2cHBi3YEb+B78SczcPfS2icsS3kU4y
 fGj0BaIYOhZPZap4RQJlSprLcAIHLR4I8QH9uOGm3dy/wLpxQfLUC/CdGAWq95rFi/YQ6wAzL
 B9IXAdSylT7O9tiEIqyy/Z1MRYvG9YsF/O9pXQNR5R6X7hPFImafOIXM4h8UfDGrqmmYhBPCT
 P0RS8wwi2oxulYQU/tix2nKlRE6eupe/jHippz8r6d+Jpd+sQ0KGFbl9mWhUR9PCJqd3rZmss
 hi0zuzfAJjqRk3uNjtgXYB7MpVs82ptONaEYOIe8zbMmIp5meBveb8Y73

When support for Vivobook fan profiles was added, the new thermal
profiles where used inconsistently.

This patch series aims to fix this issue. Compile-tested only.

Changes since v1:
- drop already applied patch
- change commit description of first patch
- add second patch based on a suggestion of Hans

Armin Wolf (2):
  platform/x86: asus-wmi: Fix inconsistent use of thermal policies
  platform/x86: asus-wmi: Use platform_profile_cycle()

 drivers/platform/x86/asus-wmi.c | 88 +++++++++------------------------
 1 file changed, 22 insertions(+), 66 deletions(-)

=2D-
2.39.5


