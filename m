Return-Path: <linux-kernel+bounces-568324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36241A693EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454311894AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73D1D5CE7;
	Wed, 19 Mar 2025 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fnGc/DpF"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28D1D54EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398831; cv=none; b=tzwyRm0xQrSlBc4HxNzsDv5j7ZtConBIvSWq5v/eLcgX0gguiDVc/SqP5XmdOXhU+C0f/N2sLiF5yLbXqhWDcRc4MEfWzcardHIyb9D8vNRyZiQVC2gSsuZVYS1QO/l1ESokIlD7Kl6Y3JBqwzdKC6AtoUZwTOaOGXeuU7h4mgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398831; c=relaxed/simple;
	bh=0J4Dj3DZLJQLFShKHhFAAKzcJR8pNwwELKytbuH1EAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJS7YNntfzxc1l38nkuEeF4eqIvkq+spTsHo04FAh0VQDmK27D2GnnM5cdRXw1qkRWLBE6CUR7nuMymr7w1o6Hhn61cw8Fywra8s1wClhRqAHFePR0u8uXlq4ah0Qz3amT0inoTUbBAe7AjuGQ+jmrjqlAUT5acNKg6qVh4Jd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fnGc/DpF; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=F4OqW
	Kmlxl0Z16U7v4S6Kvfx4lNXBOV/MAIt234mOqY=; b=fnGc/DpFfEdLF/Wkptue9
	THuRjI2/GMPnqZ6Ocs//QNP2pnk4vwks+Rp7k1naHnYvGwdO5x7KlmOyfzkganoB
	4igq9+z+ssHP4WAe4lzctpjTfpKWEdKjExtIO4ChE7dkacMqnxiaGdVq94wKK5qe
	cXbLgfeOgRH9yaRvw52DL0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3JUog5dpnBJb3AQ--.38S4;
	Wed, 19 Mar 2025 23:39:48 +0800 (CST)
From: David Wang <00107082@163.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: nvme interrupt counters got reset after suspend/resume
Date: Wed, 19 Mar 2025 23:39:10 +0800
Message-Id: <20250319153910.18684-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3JUog5dpnBJb3AQ--.38S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1rCF1ruFy8JF47tF4xZwb_yoW8CryDp3
	Z8KF1qgr48Kr4xKa4UtF47Jr1aqa4IyF4Ut3W7Jr48ta9Y9w4jkryDtF1vq3WUuF4kZw1U
	Kws5t34vy34kGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkAcVqmfa4IeLzgAAs3

Hi,

I noticed that on my system, the counters from /proc/interrupts
for nvme got reset after I suspend and then resume the system.
For example, before `systemctl suspend`:
$ cat /proc/interrupts 
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
...
  38:          0          0          0         22          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    0-edge      nvme0q0
  39:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:22:00.0    0-edge      enp34s0
  40:         78          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    1-edge      nvme0q1
  41:          0        147          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    2-edge      nvme0q2
  42:          0          0         13          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    3-edge      nvme0q3
  43:          0          0          0          9          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    4-edge      nvme0q4
  44:          0          0          0          0         87          0          0          0 IR-PCI-MSIX-0000:25:00.0    5-edge      nvme0q5
  45:          0          0          0          0          0        112          0          0 IR-PCI-MSIX-0000:25:00.0    6-edge      nvme0q6
  46:          0          0          0          0          0          0         12          0 IR-PCI-MSIX-0000:25:00.0    7-edge      nvme0q7
  47:          0          0          0          0          0          0          0          8 IR-PCI-MSIX-0000:25:00.0    8-edge      nvme0q8

And right after resume the system, values are reset to 0s:
$ cat /proc/interrupts 
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
...
  38:          0          0          0         21          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    0-edge      nvme0q0
  39:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:22:00.0    0-edge      enp34s0
  40:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    1-edge      nvme0q1
  41:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    2-edge      nvme0q2
  42:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    3-edge      nvme0q3
  43:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    4-edge      nvme0q4
  44:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    5-edge      nvme0q5
  45:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    6-edge      nvme0q6
  46:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    7-edge      nvme0q7
  47:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    8-edge      nvme0q8

This does not happend to counters for other interrupts on my system.
Not sure whether this is designed explicitly this way, or happended to be this way to make suspend/resume work,
or there is some bug behind this.
Just bring this up for discussion since I failed to find any discussion about it.

Thanks
David.


