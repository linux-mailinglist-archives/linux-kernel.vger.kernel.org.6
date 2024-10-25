Return-Path: <linux-kernel+bounces-382476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D39B0ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C5D1C21820
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6C620EA4A;
	Fri, 25 Oct 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WOwA2xzK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E36228039;
	Fri, 25 Oct 2024 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883787; cv=none; b=JY2KOvZfx7lLfh9dq4OKULhzSaF8LEsA1/+g6DZBdz6GW4RT9hOfndAaVJIx+zIHj83N4hbLsOwmk6SgpwEEUKqZFaS8N0RW2LlBhKp/hQ93bSJe7RTpXvy0z+lJneYPqK4Jac+rYUtbGVijE7lgk2393IQAWOq/hbQCpBRnd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883787; c=relaxed/simple;
	bh=xnB1dVcFgfOY4N9QbTxlNT6SPSuwN+uecbFreBuFAOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=twvsHQEb+wPMEAN/QX0WwnBwAXw9nyrZ7p7nCnu3DhkakwPX/RKeBSen/n4JwV7BMld1xolSQ/qXtAP1coqXecvSjl5s6HiahwfyYzqZWt8hI2RiR9Y4vYeQAYrYxAd2WKk68mMBMe3w4sW5MNAYuKoAlHe2mseCO/b6tJ/eT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WOwA2xzK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729883725; x=1730488525; i=w_armin@gmx.de;
	bh=BGhQC6VP9aaGuq9TUoYwgvUNWHfdLb6iHb111EpNo0Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WOwA2xzKmcWHw3Bv5UjpfAUBmE+ziswUTQUiE8pHL0NRXR3lh6NKPm112m/zABq5
	 nlZ8GLmG9MrkrxyPxFINj96NnAiI0ZiYZ5axFfHHDI6xemderS7OXPt8GswF6h/8/
	 21f0jRaxblM6Bx3W+5kiVP1eNgXeHiEO+dnbLWXF02f+Z/tmhcM6j/CBwGTy/zQ9Z
	 6dcIleWBNqlB+biiF5ZbA+PRtMRRVOArjaAD3VRATJ0a8+RxyjzJxLJ2PzbP438hH
	 roJgAMVmX7Tj4+TatEb6NxqYOgnBmSbWrezmGSlCf0H6nP2uM9RjNRHNsPfZmFe+P
	 9GbeXZPfbl5VbmFMUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MAwbp-1tAhJU25o9-002kvy; Fri, 25 Oct 2024 21:15:25 +0200
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
Subject: [PATCH 0/2] platform/x86: asus-wmi: Fix thermal profile handling
Date: Fri, 25 Oct 2024 21:15:12 +0200
Message-Id: <20241025191514.15032-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oyu/UiIohrsWqNT8hmeokpNxl3vVUJqdQM5SIVxxob2j7HziJzy
 4Xac6tOBaVeV9dNOLvRG/JGNqrpuWCCf5wpQOSE6SjlXjiJE8/1pIkPlboG4MOFE3ZVWM6J
 zWyKDQb9nYdFVMbuYDE3UJj4h0aXYYKEBCL95A1fKq1oHvTJUG5X5GllRcLmjoCNuEw9xLu
 4skk1kUFsPqG3e3WcO75Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AnKcOtlFZRA=;VFdCa4EHsAtHh9mvMSPWOhr9Ma/
 ssMYYvpvlis4u9KxPxx6R/v73qMoPwz0aew3bdH73QnmOQLNounw6HFmVJt2zQm2zRCa0CeRa
 IkT6xDlyJ+3mAcK6GjFSk/EB0326LIooytqDUo6ayxRWv8Z46FiYR/9kkA+83P3PX+znLTKCt
 aoX7rXD2hEtDX9nF3vPvaXcr6QuFL7KgFBI36NrQmZ6uNIS8dhD4rGRrl+1xiJn94Dbfpiegu
 3KC8yhwtTTwVbFq+jPmy9SKeioxyOGg45R/3k9E6JQ3qFl4fVkiVveRdqxW5k8gsQajq0oO+g
 mpCjTYPCVYY/WyWzp6qHYk18ZK8Zz26p5mMCEWXQHdllNw4bJeHEwJG1ZuFIIo7fyarJPpblk
 7H3u10JlJY5rbxdS7Nw9wLy7ACj+WvjheU5QROhUC9KFsiF0EMRS24PcLh2j0+u/Xdou4wwvv
 DMx9PxNnahJxWwhzk1to9+7B8WRAzx3Fj0BqySNLvEer4ga/sk1DZlDYe3JT13ri2gKTpgd/X
 jXPbj/31lCueylyGwEO6TUWt7DvwxDmNPvOfXI0jyHRC7ZAm2hfgRIYTel5xZhNtz7xHG1Lz6
 OpBJIhJTLNl1gvczctd2adSZXe4yhVpFyidvwBo78B0f9xlBnHgD/3mZGUYxqfw7DuclA1BLk
 1SlV9Xib2P2bhlZoPn+Gii+Gxy5g3Sy7GqW24YAKv5KxYqF0TYbBUkH3jIhMIdwpLhLInPwad
 Fdbd1gF4ez6HSAINuf8jLOTJc0bVzz56+LLYtyvCdyGqhPCFRINoAByu8F0J6E72R+eZDaW8N
 uKRgkPNsR0nWJsnYRCUZ1yO4RosA0nnOqCALFKjHiv3LA=

When support for Vivobook fan profiles was added, two mistakes where
made:

1. throttle_thermal_policy_set_default() was not called anymore during
probe.

2. The new thermal profiles where used inconsistently.

This patch series aims to fix both issues. Compile-tested only.

Armin Wolf (2):
  platform/x86: asus-wmi: Fix thermal profile initialization
  platform/x86: asus-wmi: Fix inconsistent use of thermal policies

 drivers/platform/x86/asus-wmi.c | 74 ++++++++++++++-------------------
 1 file changed, 31 insertions(+), 43 deletions(-)

=2D-
2.39.5


