Return-Path: <linux-kernel+bounces-519100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B789FA397E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E9B165356
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9623645F;
	Tue, 18 Feb 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Bt6naX0M"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCA23496F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872738; cv=none; b=pz54jJSFqJgPcIwusrCJeTrr3ZcfS9TIBUgOKWEIoxVwz9Z4offbcPtFJO3hGLY0t9ESH3Mk941wIXrTAdeS6s0ODfLnSJvhmKfDEf8+tgovK0WX6p8X5JISQ15Eg3dc4cmDx4y/ePdXFfKwi8LneKf7a6MBM1nHLosI54Mvhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872738; c=relaxed/simple;
	bh=YILd5b+WgEImMcZvqFh77mCVPV+v4tIi2NThn8rfhcA=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=M/9rMEON30oi5ChzEM8SuTslxuAT93VAqxN3lUL+tsZtuIGGAj2MrADvNrvof9uSBSty11X2wgBiaMC7e180XK36OltIhaMowZ+t6kbykO2F68JyRFOH71luAxSydUVNceQF1YHQ200I5Tl0S72oCGn7gjNbayTI+shL7OEqJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Bt6naX0M; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739872695;
	bh=YILd5b+WgEImMcZvqFh77mCVPV+v4tIi2NThn8rfhcA=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=Bt6naX0M4i7q7GznIk18ekhWhKkiorMO9gzotdjRmirA8qvQNhGvmDxM2s8JWFNyP
	 hcAyKaOh7QeNZ5B3mRticLBrBCxB2bhm7Pefmg+lh7+yizeoGkvSgzQndvGucjoD6O
	 fZ5HuVYe/3B1BOoOfkO5IrDStqwfqPrVKVLsZb7M=
X-QQ-GoodBg: 1
X-QQ-SSF: 00420000000000F0
X-QQ-FEAT: LmkY14RBebTc565ZtoBk0Us/CMUSuxshwwpAIO79bxs=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: gXDe23XLI9Uj5W8jpWSvhFtd7dLLcl8OOXB+/KUXF+s=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1739872657t6316258
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>, "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>
Cc: "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?eWFuZ3RpZXpodQ==?=" <yangtiezhu@loongson.cn>, "=?utf-8?B?bWFvYmlibw==?=" <maobibo@loongson.cn>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>, "=?utf-8?B?6ZmI6bqf6L2p?=" <chenlinxuan@uniontech.com>
Subject: Re:[PATCH] LoongArch: acpi: Make parse_acpi_topology() return void
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 18 Feb 2025 17:57:36 +0800
X-Priority: 3
Message-ID: <tencent_46D6C2824357C42E11A3C9CD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <C832CAEC20DE4FC4+20250218094027.482396-1-wangyuli@uniontech.com>
In-Reply-To: <C832CAEC20DE4FC4+20250218094027.482396-1-wangyuli@uniontech.com>
X-QQ-ReplyHash: 3688260371
X-BIZMAIL-ID: 17015835246629524927
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 18 Feb 2025 17:57:38 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NZiJZo0DdgPmxvZZTzlawGMhJn451se/jIMXPnEqCNIhtx6dp51YW8xB
	cEFIhRLlD7oTutopgNi/8bSRNBsZeXxh3qGKI3L3mBOqnZwan6S6XiT6osrgUOMHOIsQahw
	+f9UK7p3L/kLO5Y8BVdRUHQjxEu1xiwXuWFG2Vu3s79S7411gKc4KIzC/RVA9u29dBqry43
	/UPwpO4xBCrmGmSLyTsi4N4Malgx2HFSNHf0sEj/q0TsVeaiYKBSvyy+0yOa0e6KqjvJTNS
	StmvIV/qclG21VH3MGQNFek0xg+AfMXTKw0bythQ1Z/tpC503djyUHQmOS0aj/IC/ubx2zu
	tgFah6ZNVZEkj14QQuj+z5UkE79ocp3uW1hXZHIXHnNiSAqpyhytGQNgF9A64KLT/0LXpTi
	Y+P90qIh84d5ntT6IQ71mNRuxj+v5CPyHiyX0lMQz9UWxfXdp5kg6GrtFu2os9AAk62RKYm
	gB7ka76aKPg3uWx8a+8PEzj3HaZeyjG4wGTxvSJ6YF7aq36Q4h/pX+c9DwJJxT6LDQCaQ1S
	7QsS21JQExnmb75BZZ9W8PVs0TPFkwUSTlVzO8D+Er2qtPTxuAxyqXk39c0KN4asw5HG2C6
	B1/5spbZJBZs9zsyunw3u7ugx0a2p1g4jIiQY8ZsnAlP9EVF/O/VSkurvCwURmxUvv6amqb
	Me04HFju/sOpoefAf7y/IaZuaIonSOeexsHSvDW6Kv7fjLBv/pYTAUhKB5Da3/Y3X1W1Pwk
	DH3P/uxad3hTeU/DEXG+0AxHLSRLCqemaVDiKrtCUu/OQPaIpOFPH2GU42p8AS9ta/wrSEv
	+4xikqW1d1cNG2bLr3pwQbxVkgmXSCy4KQbnbKQDpIrNZG5I3Dx+GUYE1ZnVEzjIufOhAvB
	kTrrfjQs13Fc4Y4JbjWhm1dpEeR9FObH8YktkspJ4bCfTRe5PPFfyjtIA2H7WMsqMD4lZfK
	eoSRfey71MpAFMaST3kFYHP+yhf5HysMjQgdkQfzwA6r+xYZBFq0OWr6pNQX1uhAUYEdbHW
	FcxiLDbv9mixrQx0TF4MIa86ugw9LsFvvst0El7pRasjJQuisY1nAmICP8w7PyVhjUeqJG9
	w0PWAwBvz3H5KmQRmIZ1xUeySwcaAkmV/NBBLH+Tc5M
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

TkFLLCBNVVNUIGFkZCAicmV0dXJuOyIgYWZ0ZXIgInByX3dhcm4oIkludmFsaWQgQklPUyBQ
UFRUXG4iKTsiIHR3aWNlLg==


