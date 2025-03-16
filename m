Return-Path: <linux-kernel+bounces-563123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17192A63741
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBC63ADCB3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F61DBB03;
	Sun, 16 Mar 2025 19:34:39 +0000 (UTC)
Received: from b2712.mx.srv.dfn.de (b2712.mx.srv.dfn.de [194.95.235.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967F2629D;
	Sun, 16 Mar 2025 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.235.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742153679; cv=none; b=BMB4UNq6u7hrv/lj7aJz0jF7dnkEBT6syXS/WhVJNsU/5fF1QnhWkKS4Q+aCBWyrgPdOMSvMOng39MvvBkF6BwAW5G7BHgMNU9LDpfbjSIY+9lTbeYUOP0wD/q+WmEPpOn/WbMiIHAqrGn/o/l4B+xu+d7137QNoHCBm8pJCv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742153679; c=relaxed/simple;
	bh=hULb9bY+HvY16srEOmds0YHCxINq/V0Rb1Bd20SrQgk=;
	h=MIME-version:Content-type:Message-id:Date:To:Cc:From:Subject; b=GnMrS58squjsrjn2u3poZTXzYgTP9mShNKPnw0r3QZ5mbo2GsPOnw5lrXTQLrJoa4oR3pCpO5blIul2+lZzCInBQmz89ZmbqH+EZfNWFOuLZdFof71JHLasRUW70TAMAgcfTwmrEuSssG2vJHwmVFD2XfSx7oX1wEVl+jwOkVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stud.hs-bochum.de; spf=pass smtp.mailfrom=stud.hs-bochum.de; arc=none smtp.client-ip=194.95.235.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stud.hs-bochum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stud.hs-bochum.de
Received: from oms0.hs-bochum.de (mail.stud.hs-bochum.de [193.175.85.64])
	by b2712.mx.srv.dfn.de (Postfix) with ESMTP id 0AE193A00AF;
	Sun, 16 Mar 2025 20:25:45 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII; format=flowed
Received: from [192.168.178.29]
 (ip-095-223-071-235.um35.pools.vodafone-ip.de [95.223.71.235])
 by oms0.hs-bochum.de
 (Oracle Communications Messaging Server 8.1.0.9.20210415 64bit (built Apr 15
 2021)) with ESMTPSA id <0ST800784DYXJ230@oms0.hs-bochum.de>; Sun,
 16 Mar 2025 20:25:45 +0100 (CET)
Sender: sven.grewe@stud.hs-bochum.de
Message-id: <dad804b1-bfcf-4a72-bcaf-3f1137b3facc@stud.hs-bochum.de>
Date: Sun, 16 Mar 2025 20:25:44 +0100
User-Agent: Mozilla Thunderbird
Content-language: en-US
To: linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-kernel@vger.kernel.org
From: Sven Grewe <sven.grewe@stud.hs-bochum.de>
Subject: ASoC: dmic: add regulator support

Dear Maintainers,

I tested linux-next and a patch in it breaks the audio and delays the 
shutdown process on my system for a few minutes. Reverting the following 
patch seems to fix it for me in linux-next 20250314:

Author: Olivier Moysan <olivier.moysan@foss.st.com>
Date:   Thu Mar 6 18:18:40 2025 +0100

     ASoC: dmic: add regulator support

     Allow management of the regulator that may be used to supply the
     digital microphone.

     Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
     Link: 
https://patch.msgid.link/20250306171840.593443-3-olivier.moysan@foss.st.com
     Signed-off-by: Mark Brown <broonie@kernel.org>



linux-next 20250307 worked. Later versions had the problem I described 
above.

For the bisection I used the default .config from Debian's 6.12.x kernel 
when building. I build and ran them on my Samsung Galaxy Book. This 
device got a patch recently in linux-next not related to audio. That's 
why I wanted to test linux-next and found this.
Linux version 
6.14.0-rc6-next-20250314-next20250314-revertbrooniesound-grewe 
(sven@Turbine) (gcc (Debian 14.2.0-17) 14.2.0, GNU ld (GNU Binutils for 
Debian) 2.44) #1 SMP PREEMPT_DYNAMIC Sun Mar 16 16:06:58 CET 2025
Operating System: Debian GNU/Linux trixie on x86_64
Audio Chip: Realtek ALC256

Kind regards,
Sven J. Grewe

