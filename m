Return-Path: <linux-kernel+bounces-540960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F01A4B6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276403AD5B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF79A1E32B7;
	Mon,  3 Mar 2025 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OBcyIG9k"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06581E1C09
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973552; cv=none; b=UlfIddWLtcEHaqfLeumgRedfXLhamCEbsoq29Hk5oDbOlzPm9GIua0gbh1gE9N0K9m31W4hYNcBSnnH2iYEZYxJmyLt4he3ehLzQuPRoJeRMQYno+nEFBFTIbsTYK6cESl14A6CXbqVvJTLmoGGUnKaztT94puPMNR0KHO/jW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973552; c=relaxed/simple;
	bh=+GLdX9sHI8ZEONmGSp7rm95EmGqv9Wksp7L0ZbJsQls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0kgeET1PRk4kh1qJaovHzNvq8sZwSIjzts91Dp9FwKptYKDD0+f3Xu5u0QqJqD2tXrKsx70fKmIZygZYa20m6f4YULnBdK8MwzOdUxZ3RsivwfzvmZU/CcrguMiY1ibLTItzXJrgzBZPnRpRejpq2Qks3akVIOtGWOmpLZxnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OBcyIG9k; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740973413;
	bh=+GLdX9sHI8ZEONmGSp7rm95EmGqv9Wksp7L0ZbJsQls=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OBcyIG9kt4aDQucmA6mY2ppigdgwie4H8cIqPe1nlEVCqjld7gMeT2onYtRNaMvHs
	 inIfXFP4sVPcLA/rTfDfzmyiysQqS0NNwD/0sipaNd7ecn4T4n8XHyuoJZyNXsNJua
	 AXkFFna0suSH+6feKrpzR4s03WO6yBpjzO1CV68E=
X-QQ-mid: bizesmtpip3t1740973358th3q8gl
X-QQ-Originating-IP: FIUGPBJpsYmKZr5GvnZTK/CHIy6KAfMajbkZnFmbZVM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Mar 2025 11:42:35 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16988100910576150127
From: WangYuli <wangyuli@uniontech.com>
To: mingo@kernel.org
Cc: bp@alien8.de,
	chenhuacai@loongson.cn,
	chenlinxuan@uniontech.com,
	dave.hansen@linux.intel.com,
	guanwentao@uniontech.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	mingo@redhat.com,
	niecheng1@uniontech.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	wangyuli@uniontech.com,
	x86@kernel.org,
	zhanjun@uniontech.com
Subject: Re: Re: [PATCH] x86/srat: Conditional apic_id vs MAX_LOCAL_APIC comparison
Date: Mon,  3 Mar 2025 11:42:34 +0800
Message-ID: <E504BDEF131EA0DB+20250303034234.24917-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <Z8GCyyt0Dud0kvwq@gmail.com>
References: <Z8GCyyt0Dud0kvwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OM0exKGC/eNye9NliXRTMZNkVe7WRJkw/gdHnJ/KFeKwM63Gz76TpcnN
	DhlGHaeUxefFKgZFtvNyUCawv0Ccr1SS26XFtnuOmPE+0tVrGclfyJ0vHIUM2jHAm9l+I9/
	rvByek+DUFlsNhrm7CSHnPe3P+h+mMbHijh+PH63REZRgDeCmNWpHwdQhj2cpn4VAXUh/mY
	oLt+3TLxAq2ZhpzVp4mtxH65kIonkaadJ3CLbyIcq/GXWcl8+NG+HmcOOBJNAsizTXEVil0
	cH6Mg8nRcBW5aW8v68/AyqDpBK+v6DzjHWqC3c/auBo7Jq9DqmMvX/dfvRWljc0QzSy9DpH
	ILMBaTPez0n7dDcIOoCpJxbjK2LUB25z8mSrzJt3ccVMh0MBrNCPKM0e1+Cs06w8WIr8D1Y
	7UqxVAdlD4Cv/thkvCKQpiLAg7tL7eDh4bvyukUrexg9itsEi5XcuCSG7N5HpjDWdErEtkP
	3bHjV9rQ734veWO06FjiVoRxVwYwE8hAtEHlxT9lNeo8DhjnAKl2mqhrJl3t4cjOlwFEzpC
	wzoE+OM12UDoOGsIKecpFN1fRfW6p82wsldqTBkHIOZSdfvRBk9bTkAo0ssBizfgeyrKQJ+
	dYTSRkuPvg9KSHshqEE+Gcn/4UWOJi3VXD8RTzwbarUhIaGGmg7k3R7ggXowhIIZCckcaq9
	9AAAVIlIllQ7d57Vezi0WTNozugufxxI2cEP4c0w3XJF3XOrTEC1UrEe5h0TJEmpxjbaigq
	IvAuO9LP30cwR1h044w6A4vUKyw0LUWvoXSqIieuU3aI45zSiOy2WvrVdLKISuZuOTgqPM7
	9gnXw12UvGcPiuXY2UfOhSdmHi+I7sF0qOmuDKXUbeseWpEaCbzUcOrxyul1O4JmBGr08oo
	Rfu074Lhl/kfW+6utsWVc+rL9FsbFpfQ9ImdDOP0GFlrbPnUaSVV1wley6mmcV+CXbr+a06
	YSLgdZKgLqrCXdGJ/PaM/FSaRdyxFpreg2IAwnX623AcEwDWyHLEKIP+XsLkG7h9Ma40F0P
	5lUeSRiV0VyG5z0in1PFhT+ZEzRCLon7cm89rxJw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi Ingo,

The commit message already clearly explains that, uniquely,
acpi_numa_processor_affinity_init() utilizes the apic_id from the
acpi_srat_cpu_affinity struct, which is typed as u8 rather than u32.

The apic_id becomes (pa->apic_id << 8) | pa->local_sapic_eid if and
only if CONFIG_X86_X2APIC is enabled; otherwise, it remains pa->apic_id.

Consequently, even with apic_id being of type int, its maximum value is
still constrained to 255.

Thanks,
--
WangYuli

