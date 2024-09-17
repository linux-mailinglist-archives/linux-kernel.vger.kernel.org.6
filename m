Return-Path: <linux-kernel+bounces-332001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028797B3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D891C22C84
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4959E38FA1;
	Tue, 17 Sep 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rjfxqC1f"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729CAD58;
	Tue, 17 Sep 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726596138; cv=none; b=RLDyX5kVPQOvxKoBpzCrA+sv0ulHmJpd2wJoVjD23h7pGezChuTO26OBLwf25ZaeY8Ry3SYx1v/seaDxdc1nWNBpA+VPCxQhM3iP61JDs0lzRnr5ASIkBuYv/VrxNiTXHAgr8xefcb+5PkRXONJV5VO11wUkb7kkqljO9GD0vO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726596138; c=relaxed/simple;
	bh=nQ/A1DBP0pu9JWjNrlD6FHP+QrqbRzJhRlJVbeHXLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIDr/7ptrXUiC1QsXaD39eKlF73YcqUIe4Nf1s8zly/4RoE67FiS80at0ibayu6wP+qBlxoJsecdPAkCc61uXQp+LLSDJH4TQ89VxJgJpgAVgZZ7j1Q6zh4x4O/I07UNCmL54xBZ/UiZk9hca+A4DlkB3Wx0m0oSlccuSR57vIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rjfxqC1f; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=tYU3PPs4PN8YFmwwQOo1ddYMsbFBtwjLX06aAFeAeNE=; b=rjfxqC1ffU0WMyjU
	WpSqeg6653AiZpXMPnZIRU96qQXaEV/gKRIWdu04hWZgXUJcYCkQ+U04y/TGrQvuwxPjlhBnPjddL
	j9pN42CQrcTKmzOCglHVKE+8Wa/YuoP6mkeGW7r67moKWOmQBz4kf4cwA0T9+JPVBVyK1kDbkgc6l
	paWqEeC6Yji2oGH9VqaTQEp4mT4kC+xcGi9eOHYk/MiKt1YOCKv41QsSAv6MXrGfsXNpWXHoD6IYa
	2p0UKgJalQEd7xTC9cEIbgUc7Fi7+f9+/QXD6l0Uum0CiQROJF3jtomiNzNOjZyHXVs/3Cbwd8w71
	PXXuWUqbNm+SXP6J0w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sqcWX-0069Uz-2N;
	Tue, 17 Sep 2024 18:02:01 +0000
Date: Tue, 17 Sep 2024 18:02:01 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bob Gill <gillb5@telus.net>
Cc: alexander.deucher@amd.com, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: 6.11.0 crash on X startup
Message-ID: <ZunEGR6xIB2RJwxk@gallifrey>
References: <ZugStvRPjdmQmMUx@gallifrey>
 <750fb856-9361-4d25-a9b9-efb728a35a5f@telus.net>
 <Zuho6e9T08Dzrqyp@gallifrey>
 <6060922f-c1b0-4d02-819b-2438c52a78a7@telus.net>
 <ZuiWwoW5B6-BehWs@gallifrey>
 <5c6bffbf-d3df-4f16-a767-54ca02251a05@telus.net>
 <Zui5XFSLbZTTNxSf@gallifrey>
 <46236bfa-decc-4515-8909-e9e1008594d2@telus.net>
 <ZummgJJJoW1rkciE@gallifrey>
 <a65df735-31e5-4691-8e81-ee248f9e5868@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a65df735-31e5-4691-8e81-ee248f9e5868@telus.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:59:14 up 132 days,  5:13,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bob Gill (gillb5@telus.net) wrote:
> Hi.  Again, sorry for the protracted reply.
> 
> I ran uname -a > file1 and lspci -vv >> file1  to give the kernel of each so
> that if
> 
> one kernel reports something differently you can see which kernel did what. 
> I ran it

Thanks!
The only odd one I see, which I don't know if it matters, is there's an MSI
difference in 6.11;
on 6.10, MSI is enabled for both the audio and the video sub device, but on 6.11
it's disabled for the video device, but still there for the audio.
I see 'DisINTx-' on 6.11.
(There's some address differences as well, but I don't think that's a biggy).

I think that's got everything I can think of, so I'll leave it to the AMD and
regression people to follow this further.
If you can, doing a bisect between 6.10.0 and 6.11.0 could help nail it down.

Dave

> for kernels 6.10.0 and 6.11.0.
> 
> Linux freedom 6.10.0 #1 SMP PREEMPT_DYNAMIC Sun Jul 14 18:50:17 MDT 2024
> x86_64 x86_64 x86_64 GNU/Linux
> 00:00.0 Host bridge: Intel Corporation 5520/5500/X58 I/O Hub to ESI Port
> (rev 12)
>     Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O Hub to ESI Port
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
>         Address: 00000000  Data: 0000
>         Masking: 00000000  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x4 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
> 
> 00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root
> Port 1 (rev 12) (prog-if 00 [Normal decode])
>     Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin ? routed to IRQ 24
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>     I/O behind bridge: [disabled]
>     Memory behind bridge: [disabled]
>     Prefetchable memory behind bridge: [disabled]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O
> Hub PCI Express Root Port 1
>     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>         Address: fee00000  Data: 00ef
>         Masking: 00000003  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency
> L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (downgraded), Width x0 (downgraded)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>             Slot #1, PowerLimit 25.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Off, PwrInd Off, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet+ LinkState-
>         RootCap: CRSVisible+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible+
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
>     Kernel driver in use: pcieport
> 
> 00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root
> Port 3 (rev 12) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin ? routed to IRQ 25
>     Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000a000-0000afff [size=4K]
>     Memory behind bridge: fb600000-fb8fffff [size=3M]
>     Prefetchable memory behind bridge: 00000000cfe00000-00000000dfffffff
> [size=258M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O
> Hub PCI Express Root Port 3
>     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>         Address: fee00000  Data: 00ef
>         Masking: 00000003  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 5GT/s (ok), Width x4 (downgraded)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>             Slot #2, PowerLimit 25.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Off, PwrInd Off, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible+
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
>     Kernel driver in use: pcieport
> 
> 00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root
> Port 7 (rev 12) (prog-if 00 [Normal decode])
>     Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin ? routed to IRQ 26
>     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>     I/O behind bridge: [disabled]
>     Memory behind bridge: [disabled]
>     Prefetchable memory behind bridge: [disabled]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O
> Hub PCI Express Root Port 7
>     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>         Address: fee00000  Data: 00ef
>         Masking: 00000003  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (downgraded), Width x0 (downgraded)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>             Slot #5, PowerLimit 25.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Off, PwrInd Off, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet+ LinkState-
>         RootCap: CRSVisible+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible+
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
>     Kernel driver in use: pcieport
> 
> 00:14.0 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub System Management
> Registers (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
>     Kernel driver in use: i7core_edac
>     Kernel modules: i7core_edac
> 
> 00:14.1 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO and Scratch
> Pad Registers (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
> 
> 00:14.2 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Control Status and
> RAS Registers (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
> 
> 00:14.3 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Throttle Registers
> (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Kernel modules: i5500_temp
> 
> 00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #4 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 16
>     Region 4: I/O ports at 9800 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #5 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 21
>     Region 4: I/O ports at 9880 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1a.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #6 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin D routed to IRQ 19
>     Region 4: I/O ports at 9c00 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI
> Controller #2 (prog-if 20 [EHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 18
>     Region 0: Memory at fb5ff000 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
> 
> 00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD Audio
> Controller
>     Subsystem: ASUSTeK Computer Inc. 82801JI (ICH10 Family) HD Audio
> Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 31
>     Region 0: Memory at fb5f8000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee03000  Data: 0021
>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE- FLReset+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=80
>             Status:    NegoPending- InProgress-
>     Capabilities: [130 v1] Root Complex Link
>         Desc:    PortNumber=0f ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: snd_hda_intel
>     Kernel modules: snd_hda_intel
> 
> 00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 1 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
>     I/O behind bridge: 00001000-00001fff [size=4K]
>     Memory behind bridge: c0000000-c01fffff [size=2M]
>     Prefetchable memory behind bridge: 00000000faf00000-00000000faffffff
> [size=1M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x0 (downgraded)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T DeLuxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=01 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.1 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Port 2 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin B routed to IRQ 16
>     Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
>     I/O behind bridge: 00002000-00002fff [size=4K]
>     Memory behind bridge: fbc00000-fbdfffff [size=2M]
>     Prefetchable memory behind bridge: 00000000c0200000-00000000c03fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. 82801JI (ICH10
> Family) PCI Express Port 2
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=02 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.2 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 3 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin C routed to IRQ 18
>     Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
>     I/O behind bridge: 0000d000-0000dfff [size=4K]
>     Memory behind bridge: fbb00000-fbbfffff [size=1M]
>     Prefetchable memory behind bridge: 00000000c0400000-00000000c05fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T DeLuxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=03 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 5 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
>     I/O behind bridge: 0000c000-0000cfff [size=4K]
>     Memory behind bridge: fba00000-fbafffff [size=1M]
>     Prefetchable memory behind bridge: 00000000c0600000-00000000c07fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T Deluxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=05 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 6 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin B routed to IRQ 16
>     Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
>     I/O behind bridge: 0000b000-0000bfff [size=4K]
>     Memory behind bridge: fb900000-fb9fffff [size=1M]
>     Prefetchable memory behind bridge: 00000000c0800000-00000000c09fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T DeLuxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=06 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #1 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 4: I/O ports at 9080 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #2 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 19
>     Region 4: I/O ports at 9400 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #3 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 18
>     Region 4: I/O ports at 9480 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI
> Controller #1 (prog-if 20 [EHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 0: Memory at fb5fe000 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
> 
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90) (prog-if 01
> [Subtractive decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=32
>     I/O behind bridge: 0000e000-0000efff [size=4K]
>     Memory behind bridge: fbe00000-fbefffff [size=1M]
>     Prefetchable memory behind bridge: [disabled]
>     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR+
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [50] Subsystem: ASUSTeK Computer Inc. 82801 PCI Bridge
> 
> 00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface
> Controller
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>     Kernel driver in use: lpc_ich
>     Kernel modules: lpc_ich
> 
> 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI
> Controller (prog-if 01 [AHCI 1.0])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 29
>     Region 0: I/O ports at 8c00 [size=8]
>     Region 1: I/O ports at 8880 [size=4]
>     Region 2: I/O ports at 8800 [size=8]
>     Region 3: I/O ports at 8480 [size=4]
>     Region 4: I/O ports at 8400 [size=32]
>     Region 5: Memory at fb5fc000 (32-bit, non-prefetchable) [size=2K]
>     Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
>         Address: fee05000  Data: 0022
>     Capabilities: [70] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>     Capabilities: [b0] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ahci
>     Kernel modules: ahci
> 
> 00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin C routed to IRQ 18
>     Region 0: Memory at fb5fd000 (64-bit, non-prefetchable) [size=256]
>     Region 4: I/O ports at 0400 [size=32]
>     Kernel modules: i2c_i801
> 
> 02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> Upstream Port of PCI Express Switch (rev c1) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 27
>     Region 0: Memory at fb6fc000 (32-bit, non-prefetchable) [size=16K]
>     Bus: primary=02, secondary=03, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000a000-0000afff [size=4K]
>     Memory behind bridge: fb700000-fb8fffff [size=2M]
>     Prefetchable memory behind bridge: 00000000cfe00000-00000000dfffffff
> [size=258M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity+ SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [48] Vendor Specific Information: Len=08 <?>
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Express (v2) Upstream Port, MSI 00
>         DevCap:    MaxPayload 512 bytes, PhantFunc 0
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 25.000W
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1
> <64us
>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM Disabled; Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 5GT/s (downgraded), Width x4 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 4
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: EgressBlck-
>         LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
>         LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [270 v1] Secondary PCI Express
>         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>         LaneErrStat: 0
>     Capabilities: [320 v1] Latency Tolerance Reporting
>         Max snoop latency: 0ns
>         Max no snoop latency: 0ns
>     Capabilities: [400 v1] Data Link Feature <?>
>     Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
>     Capabilities: [440 v1] Lane Margining at the Receiver <?>
>     Kernel driver in use: pcieport
> 
> 03:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> Downstream Port of PCI Express Switch (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 28
>     Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000a000-0000afff [size=4K]
>     Memory behind bridge: fb700000-fb8fffff [size=2M]
>     Prefetchable memory behind bridge: 00000000cfe00000-00000000dfffffff
> [size=258M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity+ SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Express (v2) Downstream Port (Slot-), MSI 00
>         DevCap:    MaxPayload 512 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <64ns, L1 <1us
>             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM Disabled; Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 16GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 4
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- ARIFwd-
>              AtomicOpsCap: Routing+
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: EgressBlck-
>         LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
>         LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -3.5dB
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
> EqualizationPhase1+
>              EqualizationPhase2+ EqualizationPhase3+
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee04000  Data: 0020
>     Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI]
> Navi 10 XL Downstream Port of PCI Express Switch
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [270 v1] Secondary PCI Express
>         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>         LaneErrStat: 0
>     Capabilities: [2a0 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans+
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [400 v1] Data Link Feature <?>
>     Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
>     Capabilities: [440 v1] Lane Margining at the Receiver <?>
>     Kernel driver in use: pcieport
> 
> 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Device 743f (rev c1) (prog-if 00 [VGA controller])
>     Subsystem: Tul Corporation / PowerColor Device 2415
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 30
>     Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
>     Region 2: Memory at cfe00000 (64-bit, prefetchable) [size=2M]
>     Region 4: I/O ports at a000 [size=256]
>     Region 5: Memory at fb700000 (32-bit, non-prefetchable) [size=1M]
>     Expansion ROM at 000c0000 [disabled] [size=128K]
>     Capabilities: [48] Vendor Specific Information: Len=08 <?>
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <64ns, L1 <1us
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 16GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 1
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>              AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
>         LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
>         LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
> EqualizationPhase1+
>              EqualizationPhase2+ EqualizationPhase3+
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee03000  Data: 0022
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [200 v1] Physical Resizable BAR
>         BAR 0: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB
>         BAR 2: current size: 2MB, supported: 2MB 4MB 8MB 16MB 32MB 64MB
> 128MB 256MB
>     Capabilities: [240 v1] Power Budgeting <?>
>     Capabilities: [270 v1] Secondary PCI Express
>         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>         LaneErrStat: 0
>     Capabilities: [2a0 v1] Access Control Services
>         ACSCap:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [2d0 v1] Process Address Space ID (PASID)
>         PASIDCap: Exec+ Priv+, Max PASID Width: 10
>         PASIDCtl: Enable- Exec- Priv-
>     Capabilities: [320 v1] Latency Tolerance Reporting
>         Max snoop latency: 0ns
>         Max no snoop latency: 0ns
>     Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
>     Capabilities: [440 v1] Lane Margining at the Receiver <?>
>     Kernel driver in use: amdgpu
>     Kernel modules: amdgpu
> 
> 04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21 HDMI
> Audio [Radeon RX 6800/6800 XT / 6900 XT]
>     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21 HDMI Audio
> [Radeon RX 6800/6800 XT / 6900 XT]
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin B routed to IRQ 33
>     Region 0: Memory at fb8fc000 (32-bit, non-prefetchable) [size=16K]
>     Capabilities: [48] Vendor Specific Information: Len=08 <?>
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>     Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <64ns, L1 <1us
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 16GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 1
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee05000  Data: 0021
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [2a0 v1] Access Control Services
>         ACSCap:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Kernel driver in use: snd_hda_intel
>     Kernel modules: snd_hda_intel
> 
> 06:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8056 PCI-E
> Gigabit Ethernet Controller (rev 12)
>     Subsystem: ASUSTeK Computer Inc. Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Region 0: Memory at fb9fc000 (64-bit, non-prefetchable) [size=16K]
>     Region 2: I/O ports at b800 [size=256]
>     Expansion ROM at fb9c0000 [disabled] [size=128K]
>     Capabilities: [48] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [50] Vital Product Data
>         Product Name: Marvell Yukon 88E8056 Gigabit Ethernet Controller
>         Read-only fields:
>             [PN] Part number: Yukon 88E8056
>             [EC] Engineering changes: Rev. 1.2
>             [MN] Manufacture ID: Marvell
>             [SN] Serial number: AbCdEfG73035B
>             [CP] Extended capability: 01 10 cc 03
>             [RV] Reserved: checksum good, 9 byte(s) reserved
>         Read/write fields:
>             [RW] Read-write area: 121 byte(s) free
>         End
>     Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited,
> L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 unlimited
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 128 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 1f, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Kernel driver in use: sky2
>     Kernel modules: sky2
> 
> 07:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6111/6121 SATA II /
> PATA Controller (rev b2) (prog-if 8f [PCI native mode controller, supports
> both channels switched to ISA compatibility mode, supports bus mastering])
>     Subsystem: ASUSTeK Computer Inc. 88SE6111/6121 SATA II / PATA Controller
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 16
>     Region 0: I/O ports at cc00 [size=8]
>     Region 1: I/O ports at c880 [size=4]
>     Region 2: I/O ports at c800 [size=8]
>     Region 3: I/O ports at c480 [size=4]
>     Region 4: I/O ports at c400 [size=16]
>     Region 5: Memory at fbaffc00 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [48] Power Management version 2
>         Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> PME(D0+,D1+,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited,
> L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency
> L0s <256ns
>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 1f, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Kernel driver in use: pata_marvell
>     Kernel modules: ahci, pata_marvell, pata_acpi
> 
> 08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8056 PCI-E
> Gigabit Ethernet Controller (rev 12)
>     Subsystem: ASUSTeK Computer Inc. Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at fbbfc000 (64-bit, non-prefetchable) [size=16K]
>     Region 2: I/O ports at d800 [size=256]
>     Expansion ROM at fbbc0000 [disabled] [size=128K]
>     Capabilities: [48] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [50] Vital Product Data
>         Product Name: Marvell Yukon 88E8056 Gigabit Ethernet Controller
>         Read-only fields:
>             [PN] Part number: Yukon 88E8056
>             [EC] Engineering changes: Rev. 1.2
>             [MN] Manufacture ID: Marvell
>             [SN] Serial number: AbCdEfG73035B
>             [CP] Extended capability: 01 10 cc 03
>             [RV] Reserved: checksum good, 9 byte(s) reserved
>         Read/write fields:
>             [RW] Read-write area: 121 byte(s) free
>         End
>     Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited,
> L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 unlimited
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 128 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 1f, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Kernel driver in use: sky2
>     Kernel modules: sky2
> 
> 09:00.0 Multimedia video controller: Conexant Systems, Inc. CX23887/8 PCIe
> Broadcast Audio and Video Decoder with 3D Comb (rev 0f)
>     Subsystem: Hauppauge computer works Inc. CX23887/8 PCIe Broadcast Audio
> and Video Decoder with 3D Comb
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Region 0: Memory at fbc00000 (64-bit, non-prefetchable) [size=2M]
>     Capabilities: [40] Express (v1) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset- SlotPowerLimit
> 10.000W
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <2us, L1 <4us
>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [80] Power Management version 2
>         Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] Vital Product Data
>         Not readable
>     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         AERCap:    First Error Pointer: 14, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 04000001 00000003 09010000 00000000
>     Capabilities: [200 v1] Virtual Channel
>         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32+ WRR64+ WRR128-
>         Ctrl:    ArbSelect=WRR64
>         Status:    InProgress-
>         Port Arbitration Table [240] <?>
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
>             Status:    NegoPending- InProgress-
>     Kernel driver in use: cx23885
>     Kernel modules: cx23885
> 
> 0b:02.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)]
> IEEE 1394 OHCI Controller (rev c0) (prog-if 10 [OHCI])
>     Subsystem: ASUSTeK Computer Inc. Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 64 (8000ns max), Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at fbeff000 (32-bit, non-prefetchable) [size=2K]
>     Region 1: I/O ports at ec00 [size=128]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: firewire_ohci
>     Kernel modules: firewire_ohci
> 
> ff:00.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath
> Architecture Generic Non-Core Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QuickPath Architecture
> Generic Non-Core Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:00.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath
> Architecture System Address Decoder (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QuickPath Architecture
> System Address Decoder
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:02.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Link 0 (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QPI Link 0
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:02.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Physical 0 (rev
> 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QPI Physical 0
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:03.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:03.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Target Address Decoder (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Target Address Decoder
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:03.4 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Test Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Test Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Address Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Address Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Rank Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Rank Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Thermal Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Thermal Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Address Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Address Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Rank Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Rank Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Thermal Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Thermal Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Address Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Address Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Rank Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Rank Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Thermal Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Thermal Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> 
> ===========================================================================
> 
> 
> Linux freedom 6.11.0 #1 SMP PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024
> x86_64 x86_64 x86_64 GNU/Linux
> 00:00.0 Host bridge: Intel Corporation 5520/5500/X58 I/O Hub to ESI Port
> (rev 12)
>     Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O Hub to ESI Port
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
>         Address: 00000000  Data: 0000
>         Masking: 00000000  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x4 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
> 
> 00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root
> Port 1 (rev 12) (prog-if 00 [Normal decode])
>     Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin ? routed to IRQ 24
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>     I/O behind bridge: [disabled]
>     Memory behind bridge: [disabled]
>     Prefetchable memory behind bridge: [disabled]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O
> Hub PCI Express Root Port 1
>     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>         Address: fee00000  Data: 00ef
>         Masking: 00000003  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency
> L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (downgraded), Width x0 (downgraded)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>             Slot #1, PowerLimit 25.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Off, PwrInd Off, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet+ LinkState-
>         RootCap: CRSVisible+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible+
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
>     Kernel driver in use: pcieport
> 
> 00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root
> Port 3 (rev 12) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin ? routed to IRQ 25
>     Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000a000-0000afff [size=4K]
>     Memory behind bridge: fb600000-fb8fffff [size=3M]
>     Prefetchable memory behind bridge: 00000000cfe00000-00000000dfffffff
> [size=258M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O
> Hub PCI Express Root Port 3
>     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>         Address: fee00000  Data: 00ef
>         Masking: 00000003  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 5GT/s (ok), Width x4 (downgraded)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>             Slot #2, PowerLimit 25.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Off, PwrInd Off, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible+
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
>     Kernel driver in use: pcieport
> 
> 00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root
> Port 7 (rev 12) (prog-if 00 [Normal decode])
>     Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin ? routed to IRQ 26
>     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>     I/O behind bridge: [disabled]
>     Memory behind bridge: [disabled]
>     Prefetchable memory behind bridge: [disabled]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Subsystem: ASUSTeK Computer Inc. 5520/5500/X58 I/O
> Hub PCI Express Root Port 7
>     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>         Address: fee00000  Data: 00ef
>         Masking: 00000003  Pending: 00000000
>     Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <64us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (downgraded), Width x0 (downgraded)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>             Slot #5, PowerLimit 25.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Off, PwrInd Off, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet+ LinkState-
>         RootCap: CRSVisible+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible+
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [e0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn- NFERptEn- FERptEn-
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [150 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
> Len=00c <?>
>     Kernel driver in use: pcieport
> 
> 00:14.0 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub System Management
> Registers (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
>     Kernel driver in use: i7core_edac
>     Kernel modules: i7core_edac
> 
> 00:14.1 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO and Scratch
> Pad Registers (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
> 
> 00:14.2 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Control Status and
> RAS Registers (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> TransPend-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR-
>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
> EETLPPrefix-
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
> 
> 00:14.3 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Throttle Registers
> (rev 12) (prog-if 00 [8259])
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Kernel modules: i5500_temp
> 
> 00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #4 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 16
>     Region 4: I/O ports at 9800 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #5 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 21
>     Region 4: I/O ports at 9880 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1a.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #6 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin D routed to IRQ 19
>     Region 4: I/O ports at 9c00 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI
> Controller #2 (prog-if 20 [EHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 18
>     Region 0: Memory at fb5ff000 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
> 
> 00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD Audio
> Controller
>     Subsystem: ASUSTeK Computer Inc. 82801JI (ICH10 Family) HD Audio
> Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 31
>     Region 0: Memory at fb5f8000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee01000  Data: 0021
>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE- FLReset+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=80
>             Status:    NegoPending- InProgress-
>     Capabilities: [130 v1] Root Complex Link
>         Desc:    PortNumber=0f ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: snd_hda_intel
>     Kernel modules: snd_hda_intel
> 
> 00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 1 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
>     I/O behind bridge: 00001000-00001fff [size=4K]
>     Memory behind bridge: c0000000-c01fffff [size=2M]
>     Prefetchable memory behind bridge: 00000000faf00000-00000000faffffff
> [size=1M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x0 (downgraded)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T DeLuxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=01 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.1 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Port 2 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin B routed to IRQ 16
>     Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
>     I/O behind bridge: 00002000-00002fff [size=4K]
>     Memory behind bridge: fbc00000-fbdfffff [size=2M]
>     Prefetchable memory behind bridge: 00000000c0200000-00000000c03fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. 82801JI (ICH10
> Family) PCI Express Port 2
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=02 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.2 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 3 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin C routed to IRQ 18
>     Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
>     I/O behind bridge: 0000d000-0000dfff [size=4K]
>     Memory behind bridge: fbb00000-fbbfffff [size=1M]
>     Prefetchable memory behind bridge: 00000000c0400000-00000000c05fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T DeLuxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=03 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 5 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
>     I/O behind bridge: 0000c000-0000cfff [size=4K]
>     Memory behind bridge: fba00000-fbafffff [size=1M]
>     Prefetchable memory behind bridge: 00000000c0600000-00000000c07fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T Deluxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=05 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
> Root Port 6 (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin B routed to IRQ 16
>     Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
>     I/O behind bridge: 0000b000-0000bfff [size=4K]
>     Memory behind bridge: fb900000-fb9fffff [size=1M]
>     Prefetchable memory behind bridge: 00000000c0800000-00000000c09fffff
> [size=2M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCap: CRSVisible-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P6T DeLuxe
> Motherboard
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=06 ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: pcieport
> 
> 00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #1 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 4: I/O ports at 9080 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #2 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 19
>     Region 4: I/O ports at 9400 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI
> Controller #3 (prog-if 00 [UHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 18
>     Region 4: I/O ports at 9480 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI
> Controller #1 (prog-if 20 [EHCI])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 0: Memory at fb5fe000 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
> 
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90) (prog-if 01
> [Subtractive decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=32
>     I/O behind bridge: 0000e000-0000efff [size=4K]
>     Memory behind bridge: fbe00000-fbefffff [size=1M]
>     Prefetchable memory behind bridge: [disabled]
>     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR+
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [50] Subsystem: ASUSTeK Computer Inc. 82801 PCI Bridge
> 
> 00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface
> Controller
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>     Kernel driver in use: lpc_ich
>     Kernel modules: lpc_ich
> 
> 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI
> Controller (prog-if 01 [AHCI 1.0])
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 29
>     Region 0: I/O ports at 8c00 [size=8]
>     Region 1: I/O ports at 8880 [size=4]
>     Region 2: I/O ports at 8800 [size=8]
>     Region 3: I/O ports at 8480 [size=4]
>     Region 4: I/O ports at 8400 [size=32]
>     Region 5: Memory at fb5fc000 (32-bit, non-prefetchable) [size=2K]
>     Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
>         Address: fee06000  Data: 0021
>     Capabilities: [70] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>     Capabilities: [b0] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ahci
>     Kernel modules: ahci
> 
> 00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
>     Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin C routed to IRQ 18
>     Region 0: Memory at fb5fd000 (64-bit, non-prefetchable) [size=256]
>     Region 4: I/O ports at 0400 [size=32]
>     Kernel modules: i2c_i801
> 
> 02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> Upstream Port of PCI Express Switch (rev c1) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 27
>     Region 0: Memory at fb6fc000 (32-bit, non-prefetchable) [size=16K]
>     Bus: primary=02, secondary=03, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000a000-0000afff [size=4K]
>     Memory behind bridge: fb700000-fb8fffff [size=2M]
>     Prefetchable memory behind bridge: 00000000cfe00000-00000000dfffffff
> [size=258M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity+ SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [48] Vendor Specific Information: Len=08 <?>
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Express (v2) Upstream Port, MSI 00
>         DevCap:    MaxPayload 512 bytes, PhantFunc 0
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 25.000W
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1
> <64us
>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM Disabled; Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 5GT/s (downgraded), Width x4 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 4
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: EgressBlck-
>         LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
>         LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [270 v1] Secondary PCI Express
>         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>         LaneErrStat: 0
>     Capabilities: [320 v1] Latency Tolerance Reporting
>         Max snoop latency: 0ns
>         Max no snoop latency: 0ns
>     Capabilities: [400 v1] Data Link Feature <?>
>     Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
>     Capabilities: [440 v1] Lane Margining at the Receiver <?>
>     Kernel driver in use: pcieport
> 
> 03:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> Downstream Port of PCI Express Switch (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 28
>     Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000a000-0000afff [size=4K]
>     Memory behind bridge: fb700000-fb8fffff [size=2M]
>     Prefetchable memory behind bridge: 00000000cfe00000-00000000dfffffff
> [size=258M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity+ SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Express (v2) Downstream Port (Slot-), MSI 00
>         DevCap:    MaxPayload 512 bytes, PhantFunc 0
>             ExtTag+ RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <64ns, L1 <1us
>             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM Disabled; Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 16GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP-
> LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 4
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS- ARIFwd-
>              AtomicOpsCap: Routing+
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled, ARIFwd-
>              AtomicOpsCtl: EgressBlck-
>         LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
>         LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -3.5dB
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
> EqualizationPhase1+
>              EqualizationPhase2+ EqualizationPhase3+
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee04000  Data: 0020
>     Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI]
> Navi 10 XL Downstream Port of PCI Express Switch
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [270 v1] Secondary PCI Express
>         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>         LaneErrStat: 0
>     Capabilities: [2a0 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans+
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [400 v1] Data Link Feature <?>
>     Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
>     Capabilities: [440 v1] Lane Margining at the Receiver <?>
>     Kernel driver in use: pcieport
> 
> 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Device 743f (rev c1) (prog-if 00 [VGA controller])
>     Subsystem: Tul Corporation / PowerColor Device 2415
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 10
>     Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
>     Region 2: Memory at cfe00000 (64-bit, prefetchable) [size=2M]
>     Region 4: I/O ports at a000 [size=256]
>     Region 5: Memory at fb700000 (32-bit, non-prefetchable) [size=1M]
>     Expansion ROM at 000c0000 [disabled] [size=128K]
>     Capabilities: [48] Vendor Specific Information: Len=08 <?>
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <64ns, L1 <1us
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 16GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 1
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>              AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
>         LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
> 2Retimers+ DRS-
>         LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
> EqualizationPhase1+
>              EqualizationPhase2+ EqualizationPhase3+
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [200 v1] Physical Resizable BAR
>         BAR 0: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB
>         BAR 2: current size: 2MB, supported: 2MB 4MB 8MB 16MB 32MB 64MB
> 128MB 256MB
>     Capabilities: [240 v1] Power Budgeting <?>
>     Capabilities: [270 v1] Secondary PCI Express
>         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>         LaneErrStat: 0
>     Capabilities: [2a0 v1] Access Control Services
>         ACSCap:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Capabilities: [2d0 v1] Process Address Space ID (PASID)
>         PASIDCap: Exec+ Priv+, Max PASID Width: 10
>         PASIDCtl: Enable- Exec- Priv-
>     Capabilities: [320 v1] Latency Tolerance Reporting
>         Max snoop latency: 0ns
>         Max no snoop latency: 0ns
>     Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
>     Capabilities: [440 v1] Lane Margining at the Receiver <?>
>     Kernel modules: amdgpu
> 
> 04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21 HDMI
> Audio [Radeon RX 6800/6800 XT / 6900 XT]
>     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21 HDMI Audio
> [Radeon RX 6800/6800 XT / 6900 XT]
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin B routed to IRQ 32
>     Region 0: Memory at fb8fc000 (32-bit, non-prefetchable) [size=16K]
>     Capabilities: [48] Vendor Specific Information: Len=08 <?>
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>     Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <64ns, L1 <1us
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 16GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>              10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
> EETLPPrefix+, MaxEETLPPrefixes 1
>              EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>              FRS-
>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF
> Disabled,
>              AtomicOpsCtl: ReqEn-
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
> EqualizationPhase1-
>              EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>              Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee03000  Data: 0021
>     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>     Capabilities: [150 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [2a0 v1] Access Control Services
>         ACSCap:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>     Kernel driver in use: snd_hda_intel
>     Kernel modules: snd_hda_intel
> 
> 06:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8056 PCI-E
> Gigabit Ethernet Controller (rev 12)
>     Subsystem: ASUSTeK Computer Inc. Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Region 0: Memory at fb9fc000 (64-bit, non-prefetchable) [size=16K]
>     Region 2: I/O ports at b800 [size=256]
>     Expansion ROM at fb9c0000 [disabled] [size=128K]
>     Capabilities: [48] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [50] Vital Product Data
>         Product Name: Marvell Yukon 88E8056 Gigabit Ethernet Controller
>         Read-only fields:
>             [PN] Part number: Yukon 88E8056
>             [EC] Engineering changes: Rev. 1.2
>             [MN] Manufacture ID: Marvell
>             [SN] Serial number: AbCdEfG73035B
>             [CP] Extended capability: 01 10 cc 03
>             [RV] Reserved: checksum good, 9 byte(s) reserved
>         Read/write fields:
>             [RW] Read-write area: 121 byte(s) free
>         End
>     Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited,
> L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 unlimited
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 128 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 1f, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Kernel driver in use: sky2
>     Kernel modules: sky2
> 
> 07:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6111/6121 SATA II /
> PATA Controller (rev b2) (prog-if 8f [PCI native mode controller, supports
> both channels switched to ISA compatibility mode, supports bus mastering])
>     Subsystem: ASUSTeK Computer Inc. 88SE6111/6121 SATA II / PATA Controller
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 16
>     Region 0: I/O ports at cc00 [size=8]
>     Region 1: I/O ports at c880 [size=4]
>     Region 2: I/O ports at c800 [size=8]
>     Region 3: I/O ports at c480 [size=4]
>     Region 4: I/O ports at c400 [size=16]
>     Region 5: Memory at fbaffc00 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [48] Power Management version 2
>         Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> PME(D0+,D1+,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited,
> L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency
> L0s <256ns
>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 1f, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Kernel driver in use: pata_marvell
>     Kernel modules: ahci, pata_marvell, pata_acpi
> 
> 08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8056 PCI-E
> Gigabit Ethernet Controller (rev 12)
>     Subsystem: ASUSTeK Computer Inc. Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at fbbfc000 (64-bit, non-prefetchable) [size=16K]
>     Region 2: I/O ports at d800 [size=256]
>     Expansion ROM at fbbc0000 [disabled] [size=128K]
>     Capabilities: [48] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [50] Vital Product Data
>         Product Name: Marvell Yukon 88E8056 Gigabit Ethernet Controller
>         Read-only fields:
>             [PN] Part number: Yukon 88E8056
>             [EC] Engineering changes: Rev. 1.2
>             [MN] Manufacture ID: Marvell
>             [SN] Serial number: AbCdEfG73035B
>             [CP] Extended capability: 01 10 cc 03
>             [RV] Reserved: checksum good, 9 byte(s) reserved
>         Read/write fields:
>             [RW] Read-write area: 121 byte(s) free
>         End
>     Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited,
> L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 unlimited
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 128 bytes, Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 1f, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Kernel driver in use: sky2
>     Kernel modules: sky2
> 
> 09:00.0 Multimedia video controller: Conexant Systems, Inc. CX23887/8 PCIe
> Broadcast Audio and Video Decoder with 3D Comb (rev 0f)
>     Subsystem: Hauppauge computer works Inc. CX23887/8 PCIe Broadcast Audio
> and Video Decoder with 3D Comb
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Region 0: Memory at fbc00000 (64-bit, non-prefetchable) [size=2M]
>     Capabilities: [40] Express (v1) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset- SlotPowerLimit
> 10.000W
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr-
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <2us, L1 <4us
>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [80] Power Management version 2
>         Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] Vital Product Data
>         Not readable
>     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         AERCap:    First Error Pointer: 14, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 04000001 00000003 09010000 00000000
>     Capabilities: [200 v1] Virtual Channel
>         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32+ WRR64+ WRR128-
>         Ctrl:    ArbSelect=WRR64
>         Status:    InProgress-
>         Port Arbitration Table [240] <?>
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
>             Status:    NegoPending- InProgress-
>     Kernel driver in use: cx23885
>     Kernel modules: cx23885
> 
> 0b:02.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)]
> IEEE 1394 OHCI Controller (rev c0) (prog-if 10 [OHCI])
>     Subsystem: ASUSTeK Computer Inc. Motherboard
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 64 (8000ns max), Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at fbeff000 (32-bit, non-prefetchable) [size=2K]
>     Region 1: I/O ports at ec00 [size=128]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: firewire_ohci
>     Kernel modules: firewire_ohci
> 
> ff:00.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath
> Architecture Generic Non-Core Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QuickPath Architecture
> Generic Non-Core Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:00.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath
> Architecture System Address Decoder (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QuickPath Architecture
> System Address Decoder
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:02.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Link 0 (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QPI Link 0
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:02.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Physical 0 (rev
> 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 QPI Physical 0
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:03.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:03.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Target Address Decoder (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Target Address Decoder
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:03.4 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Test Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Test Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Address Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Address Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Rank Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Rank Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:04.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Thermal Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 0 Thermal Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Address Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Address Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Rank Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Rank Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:05.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Thermal Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 1 Thermal Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Address Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Address Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Rank Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Rank Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> ff:06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Thermal Control Registers (rev 04)
>     Subsystem: Intel Corporation Xeon 5500/Core i7 Integrated Memory
> Controller Channel 2 Thermal Control Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
> 
> 
> 
> 
> 
> On 2024-09-17 09:55, Dr. David Alan Gilbert wrote:
> > * Bob Gill (gillb5@telus.net) wrote:
> > > Hi.  Sorry for the delayed reply.
> > > 
> > > When it crashes, the caps lock key stops responding. Unplug/replug the
> > > keyboard usb connection also does
> > OK, so I'm copying two other addresses in on the conversation;
> > the regression list and Alex Deucher who is one of the AMDGPU maintainers.
> > 
> > 
> > > nothing.  After the crash, the caps lock key does not light up. Likewise the
> > > power and reset buttons on the front of the case stop responding, I have to
> > > shut
> > > off/reset the computer with the power bar.
> > OK, so solid hang.
> > 
> > >    However, in answering your
> > > questions, I have
> > > 
> > > done a bit more testing.  If I start using 6.11.0 in recovery mode, enable
> > > networking,
> > > 
> > > drop to the terminal, then run "service lightdm start", it crashes, but if
> > > run
> > > 
> > > startx, x starts (but I have two monitors and it only starts on one), but
> > > inxi -G shows that the amdgpu loadable kernel module is not in use.  Also
> > > the x server is really slow.
> > > 
> > > On 6.10.0:
> > > 
> > >   inxi -G gives:
> > > 
> > > Graphics:
> > >    Device-1: AMD driver: amdgpu v: kernel
> > >    Device-2: Conexant Systems CX23887/8 PCIe Broadcast Audio and Video
> > >      Decoder with 3D Comb
> > >      driver: cx23885 v: 0.0.4
> > >    Device-3: Razer USA Kiyo Pro type: USB driver: snd-usb-audio,uvcvideo
> > >    Device-4: Realtek RTL2838 DVB-T type: USB driver: N/A
> > >    Display: x11 server: X.Org v: 1.21.1.4 driver: X: loaded: amdgpu,ati
> > >      unloaded: fbdev,modesetting,radeon,vesa gpu: amdgpu resolution:
> > >      1: 1920x1080~60Hz 2: 1920x1080~60Hz
> > >    OpenGL:
> > >      renderer: AMD Radeon RX 6500 XT (navi24 LLVM 15.0.7 DRM 3.57 6.10.0)
> > >      v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.2
> > Instead of inxi, can you give us the output of:
> > 
> >    lspci -vv
> > 
> > It gives loads more detail.
> > 
> > > On 6.11.0: inxi -G gives:
> > > 
> > > Graphics:
> > >    Device-1: AMD driver: N/A
> > >    Device-2: Conexant Systems CX23887/8 PCIe Broadcast Audio and Video
> > >      Decoder with 3D Comb
> > >      driver: cx23885 v: 0.0.4
> > >    Device-3: Razer USA Kiyo Pro type: USB driver: snd-usb-audio,uvcvideo
> > >    Device-4: Realtek RTL2838 DVB-T type: USB driver: N/A
> > >    Display: server: X.Org v: 1.21.1.4 driver: X: loaded: ati,vesa
> > >      unloaded: fbdev,modesetting,radeon gpu: cx23885 resolution: 1920x1080
> > >    OpenGL: renderer: llvmpipe (LLVM 15.0.7 128 bits)
> > >      v: 4.5 Mesa 23.2.1-1ubuntu3.1~22.04.2
> > > 
> > > 
> > > I know a lot of changes happened to /lib/modules/<kernel
> > > version>/kernel/drivers/gpu/amd/amdgpu/amdgpu.ko
> > > 
> > > The 6.10.0 version is 523 megabytes and the 6.11.0 version is 580
> > > megabytes.  I don't want to point my finger and say "that", but for some
> > > reason my 6.11.0 kernel doesn't seem to like the amdgpu kernel object.  Most
> > > of my hardware (tylersberg/nehalem, motherboard) is fairly old, but the
> > > graphics card is less than 2 years old.  Maybe that's why
> > > 
> > > I hit a corner case.
> > Yeh these things happen.
> > 
> > Dave
> > 
> > > Thanks for your reply.
> > > 
> > > On 2024-09-16 17:03, Dr. David Alan Gilbert wrote:
> > > > * Bob Gill (gillb5@telus.net) wrote:
> > > > > So I think I know what you are look for.  My grub line is
> > > > > 
> > > > > "quiet splash" without modeset.
> > > > > 
> > > > > I don't know how to log dmesg automatically from boot.  If I
> > > > > 
> > > > > start from a recovery kernel in the bootloader, I can give you dmesg,
> > > > > 
> > > > > but if I start from a regular kernel (6.11.0 for example), as soon as it
> > > > > 
> > > > > gets to the X server, it crashes the system.  I can't type ctrl-alt-1
> > > > > moments after the bootloader screen disappears
> > > > Oh, I didn't understand that from your initial report - I thought it was
> > > > only X not starting.
> > > > 
> > > > > (while its still reading the kernel source from disk and loading it into
> > > > > memory)  to get to a
> > > > > 
> > > > > terminal and avoid the X server (I do attempt it, but have never been
> > > > > successful).  As soon as it tries to start the X server, the system
> > > > > crashes.  As I understand it, dmesg is stored in a ring buffer (and does not
> > > > > survive reboot).
> > > > > 
> > > > > Did you want the output of /var/log/kern.log  (or /var/log/kern.log.1)?
> > > > OK, so if you do have a boot message from the failed kernel without the nomodeset
> > > > then yes that would be great.  It depends on your distro where it would put that,
> > > > and a lot of luck whether it manages to get to disk before the crash.
> > > > 
> > > > Some thoughts:
> > > >     a) When it crashes, you say ctrl-alt-1 doesn't work - does alt-sysrq-h do anything?
> > > >     b) How about caps-lock when it crashes - does the light change?
> > > >     c) Can you boot into non-graphics, - e.g. something like adding
> > > >           systemd.unit=multi-user.target
> > > > 
> > > >        I think should get you a text login? (Depending on distro etc)
> > > >        If that fails, try just adding the word    single
> > > > 
> > > > Dave
> > > > 
> > > > 
> > > > > On 2024-09-16 14:36, Dr. David Alan Gilbert wrote:
> > > > > > * Bob Gill (gillb5@telus.net) wrote:
> > > > > > > OK, so my grub line looks like "quiet splash nomodeset"
> > > > > > Sorry, no; I was asking for a 6.11.0 boot *without* the nomodeset - in the same
> > > > > > way that the 6.10.0 dmesg boots so we can compare them.
> > > > > > 
> > > > > > > I have two monitors, of which only the main monitor starts with an X server
> > > > > > > (and the response is slow).
> > > > > > > 
> > > > > > > Here is the result of dmesg.  The parts that look interesting are around the
> > > > > > > 7.3 second mark that say
> > > > > > > 
> > > > > > > "ACPI: OSL: Resource conflict; ACPI support missing from driver?"
> > > > > > It's not necessarily relevant.
> > > > > > 
> > > > > > Dave
> > > > > > 
> > > > > > > Oh, and thanks for replying.
> > > > > > > 
> > > > > > > [    0.000000] Linux version 6.11.0 (root@freedom) (gcc (Ubuntu
> > > > > > > 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP
> > > > > > > PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024
> > > > > > > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.11.0
> > > > > > > root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro quiet splash nomodeset
> > > > > > > [    0.000000] KERNEL supported cpus:
> > > > > > > [    0.000000]   Intel GenuineIntel
> > > > > > > [    0.000000]   AMD AuthenticAMD
> > > > > > > [    0.000000]   Hygon HygonGenuine
> > > > > > > [    0.000000]   Centaur CentaurHauls
> > > > > > > [    0.000000]   zhaoxin   Shanghai
> > > > > > > [    0.000000] BIOS-provided physical RAM map:
> > > > > > > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
> > > > > > > [    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff]
> > > > > > > reserved
> > > > > > > [    0.000000] BIOS-e820: [mem 0x00000000000e4c00-0x00000000000fffff]
> > > > > > > reserved
> > > > > > > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
> > > > > > > [    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] ACPI
> > > > > > > data
> > > > > > > [    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7dbfff] ACPI
> > > > > > > NVS
> > > > > > > [    0.000000] BIOS-e820: [mem 0x00000000bf7dc000-0x00000000bfffffff]
> > > > > > > reserved
> > > > > > > [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
> > > > > > > reserved
> > > > > > > [    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff]
> > > > > > > reserved
> > > > > > > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000033fffffff] usable
> > > > > > > [    0.000000] NX (Execute Disable) protection: active
> > > > > > > [    0.000000] APIC: Static calls initialized
> > > > > > > [    0.000000] SMBIOS 2.5 present.
> > > > > > > [    0.000000] DMI: System manufacturer System Product Name/P6T DELUXE, BIOS
> > > > > > > 2209    09/21/2010
> > > > > > > [    0.000000] DMI: Memory slots populated: 6/6
> > > > > > > [    0.000000] tsc: Fast TSC calibration using PIT
> > > > > > > [    0.000000] tsc: Detected 2672.776 MHz processor
> > > > > > > [    0.001528] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> > > > > > > [    0.001534] e820: remove [mem 0x000a0000-0x000fffff] usable
> > > > > > > [    0.001544] last_pfn = 0x340000 max_arch_pfn = 0x400000000
> > > > > > > [    0.001553] total RAM covered: 12280M
> > > > > > > [    0.001829] Found optimal setting for mtrr clean up
> > > > > > > [    0.001830]  gran_size: 64K     chunk_size: 16M     num_reg: 6     lose
> > > > > > > cover RAM: 0G
> > > > > > > [    0.001837] MTRR map: 8 entries (5 fixed + 3 variable; max 21), built
> > > > > > > from 8 variable MTRRs
> > > > > > > [    0.001841] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB WP  UC- WT
> > > > > > > [    0.002807] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
> > > > > > > [    0.002820] last_pfn = 0xbf798 max_arch_pfn = 0x400000000
> > > > > > > [    0.014822] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
> > > > > > > [    0.015378] RAMDISK: [mem 0x0b466000-0x37feefff]
> > > > > > > [    0.015390] ACPI: Early table checksum verification disabled
> > > > > > > [    0.015394] ACPI: RSDP 0x00000000000FB150 000024 (v02 ACPIAM)
> > > > > > > [    0.015401] ACPI: XSDT 0x00000000BF780100 000064 (v01 092110 XSDT0924
> > > > > > > 20100921 MSFT 00000097)
> > > > > > > [    0.015410] ACPI: FACP 0x00000000BF780290 0000F4 (v03 092110 FACP0924
> > > > > > > 20100921 MSFT 00000097)
> > > > > > > [    0.015420] ACPI: DSDT 0x00000000BF7804B0 00B69B (v01 A1087 A1087001
> > > > > > > 00000001 INTL 20060113)
> > > > > > > [    0.015426] ACPI: FACS 0x00000000BF798000 000040
> > > > > > > [    0.015432] ACPI: FACS 0x00000000BF798000 000040
> > > > > > > [    0.015437] ACPI: APIC 0x00000000BF780390 0000D8 (v01 092110 APIC0924
> > > > > > > 20100921 MSFT 00000097)
> > > > > > > [    0.015443] ACPI: MCFG 0x00000000BF780470 00003C (v01 092110 OEMMCFG
> > > > > > > 20100921 MSFT 00000097)
> > > > > > > [    0.015449] ACPI: OEMB 0x00000000BF798040 000072 (v01 092110 OEMB0924
> > > > > > > 20100921 MSFT 00000097)
> > > > > > > [    0.015456] ACPI: HPET 0x00000000BF78F4B0 000038 (v01 092110 OEMHPET
> > > > > > > 20100921 MSFT 00000097)
> > > > > > > [    0.015462] ACPI: DMAR 0x00000000BF7980C0 000138 (v01 AMI OEMDMAR
> > > > > > > 00000001 MSFT 00000097)
> > > > > > > [    0.015468] ACPI: OSFR 0x00000000BF78F4F0 0000B0 (v01 092110 OEMOSFR
> > > > > > > 20100921 MSFT 00000097)
> > > > > > > [    0.015474] ACPI: SSDT 0x00000000BF799E10 000363 (v01 DpgPmm CpuPm
> > > > > > > 00000012 INTL 20060113)
> > > > > > > [    0.015480] ACPI: Reserving FACP table memory at [mem
> > > > > > > 0xbf780290-0xbf780383]
> > > > > > > [    0.015482] ACPI: Reserving DSDT table memory at [mem
> > > > > > > 0xbf7804b0-0xbf78bb4a]
> > > > > > > [    0.015484] ACPI: Reserving FACS table memory at [mem
> > > > > > > 0xbf798000-0xbf79803f]
> > > > > > > [    0.015485] ACPI: Reserving FACS table memory at [mem
> > > > > > > 0xbf798000-0xbf79803f]
> > > > > > > [    0.015487] ACPI: Reserving APIC table memory at [mem
> > > > > > > 0xbf780390-0xbf780467]
> > > > > > > [    0.015489] ACPI: Reserving MCFG table memory at [mem
> > > > > > > 0xbf780470-0xbf7804ab]
> > > > > > > [    0.015491] ACPI: Reserving OEMB table memory at [mem
> > > > > > > 0xbf798040-0xbf7980b1]
> > > > > > > [    0.015492] ACPI: Reserving HPET table memory at [mem
> > > > > > > 0xbf78f4b0-0xbf78f4e7]
> > > > > > > [    0.015494] ACPI: Reserving DMAR table memory at [mem
> > > > > > > 0xbf7980c0-0xbf7981f7]
> > > > > > > [    0.015496] ACPI: Reserving OSFR table memory at [mem
> > > > > > > 0xbf78f4f0-0xbf78f59f]
> > > > > > > [    0.015498] ACPI: Reserving SSDT table memory at [mem
> > > > > > > 0xbf799e10-0xbf79a172]
> > > > > > > [    0.015676] No NUMA configuration found
> > > > > > > [    0.015678] Faking a node at [mem 0x0000000000000000-0x000000033fffffff]
> > > > > > > [    0.015692] NODE_DATA(0) allocated [mem 0x33ffcd000-0x33fff7fff]
> > > > > > > [    0.016090] Zone ranges:
> > > > > > > [    0.016092]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > > > > > > [    0.016095]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> > > > > > > [    0.016098]   Normal   [mem 0x0000000100000000-0x000000033fffffff]
> > > > > > > [    0.016100]   Device   empty
> > > > > > > [    0.016102] Movable zone start for each node
> > > > > > > [    0.016106] Early memory node ranges
> > > > > > > [    0.016106]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
> > > > > > > [    0.016109]   node   0: [mem 0x0000000000100000-0x00000000bf77ffff]
> > > > > > > [    0.016112]   node   0: [mem 0x0000000100000000-0x000000033fffffff]
> > > > > > > [    0.016116] Initmem setup node 0 [mem
> > > > > > > 0x0000000000001000-0x000000033fffffff]
> > > > > > > [    0.016124] On node 0, zone DMA: 1 pages in unavailable ranges
> > > > > > > [    0.016158] On node 0, zone DMA: 98 pages in unavailable ranges
> > > > > > > [    0.043074] On node 0, zone Normal: 2176 pages in unavailable ranges
> > > > > > > [    0.043371] ACPI: PM-Timer IO Port: 0x808
> > > > > > > [    0.043400] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI
> > > > > > > 0-23
> > > > > > > [    0.043408] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI
> > > > > > > 24-47
> > > > > > > [    0.043412] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > > > > > > [    0.043415] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > > > > > > [    0.043423] ACPI: Using ACPI (MADT) for SMP configuration information
> > > > > > > [    0.043426] ACPI: HPET id: 0x8086a301 base: 0xfed00000
> > > > > > > [    0.043442] CPU topo: Max. logical packages:   2
> > > > > > > [    0.043444] CPU topo: Max. logical dies:       2
> > > > > > > [    0.043445] CPU topo: Max. dies per package:   1
> > > > > > > [    0.043456] CPU topo: Max. threads per core:   2
> > > > > > > [    0.043458] CPU topo: Num. cores per package:     4
> > > > > > > [    0.043459] CPU topo: Num. threads per package:   8
> > > > > > > [    0.043460] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs
> > > > > > > [    0.043478] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0x00000000-0x00000fff]
> > > > > > > [    0.043482] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0x0009e000-0x0009efff]
> > > > > > > [    0.043483] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0x0009f000-0x0009ffff]
> > > > > > > [    0.043485] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0x000a0000-0x000e4fff]
> > > > > > > [    0.043487] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0x000e5000-0x000fffff]
> > > > > > > [    0.043489] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0xbf780000-0xbf797fff]
> > > > > > > [    0.043491] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0xbf798000-0xbf7dbfff]
> > > > > > > [    0.043493] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0xbf7dc000-0xbfffffff]
> > > > > > > [    0.043494] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0xc0000000-0xfedfffff]
> > > > > > > [    0.043496] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0xfee00000-0xfee00fff]
> > > > > > > [    0.043497] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0xfee01000-0xffdfffff]
> > > > > > > [    0.043499] PM: hibernation: Registered nosave memory: [mem
> > > > > > > 0xffe00000-0xffffffff]
> > > > > > > [    0.043501] [mem 0xc0000000-0xfedfffff] available for PCI devices
> > > > > > > [    0.043503] Booting paravirtualized kernel on bare hardware
> > > > > > > [    0.043507] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:
> > > > > > > 0xffffffff, max_idle_ns: 7645519600211568 ns
> > > > > > > [    0.043517] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16
> > > > > > > nr_node_ids:1
> > > > > > > [    0.045202] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
> > > > > > > [    0.045216] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
> > > > > > > [    0.045221] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
> > > > > > > [    0.045232] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
> > > > > > > [    0.045264] Kernel command line: BOOT_IMAGE=/vmlinuz-6.11.0
> > > > > > > root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro quiet splash nomodeset
> > > > > > > [    0.045420] Booted with the nomodeset parameter. Only the system
> > > > > > > framebuffer will be available
> > > > > > > [    0.045424] Unknown kernel command line parameters "splash
> > > > > > > BOOT_IMAGE=/vmlinuz-6.11.0", will be passed to user space.
> > > > > > > [    0.047571] Dentry cache hash table entries: 2097152 (order: 12, 16777216
> > > > > > > bytes, linear)
> > > > > > > [    0.048684] Inode-cache hash table entries: 1048576 (order: 11, 8388608
> > > > > > > bytes, linear)
> > > > > > > [    0.049079] Fallback order for Node 0: 0
> > > > > > > [    0.049086] Built 1 zonelists, mobility grouping on.  Total pages:
> > > > > > > 3143453
> > > > > > > [    0.049088] Policy zone: Normal
> > > > > > > [    0.049100] mem auto-init: stack:off, heap alloc:on, heap free:off
> > > > > > > [    0.049115] software IO TLB: area num 16.
> > > > > > > [    0.128195] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
> > > > > > > [    0.128395] Kernel/User page tables isolation: enabled
> > > > > > > [    0.128531] ftrace: allocating 53163 entries in 208 pages
> > > > > > > [    0.139782] ftrace: allocated 208 pages with 3 groups
> > > > > > > [    0.140826] Dynamic Preempt: voluntary
> > > > > > > [    0.141193] rcu: Preemptible hierarchical RCU implementation.
> > > > > > > [    0.141195] rcu:     RCU restricting CPUs from NR_CPUS=8192 to
> > > > > > > nr_cpu_ids=16.
> > > > > > > [    0.141198]     Trampoline variant of Tasks RCU enabled.
> > > > > > > [    0.141199]     Rude variant of Tasks RCU enabled.
> > > > > > > [    0.141200]     Tracing variant of Tasks RCU enabled.
> > > > > > > [    0.141201] rcu: RCU calculated value of scheduler-enlistment delay is 25
> > > > > > > jiffies.
> > > > > > > [    0.141202] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> > > > > > > [    0.141227] RCU Tasks: Setting shift to 4 and lim to 1
> > > > > > > rcu_task_cb_adjust=1.
> > > > > > > [    0.141231] RCU Tasks Rude: Setting shift to 4 and lim to 1
> > > > > > > rcu_task_cb_adjust=1.
> > > > > > > [    0.141235] RCU Tasks Trace: Setting shift to 4 and lim to 1
> > > > > > > rcu_task_cb_adjust=1.
> > > > > > > [    0.147244] NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
> > > > > > > [    0.147513] rcu: srcu_init: Setting srcu_struct sizes based on
> > > > > > > contention.
> > > > > > > [    0.147681] Console: colour dummy device 80x25
> > > > > > > [    0.147685] printk: legacy console [tty0] enabled
> > > > > > > [    0.148030] ACPI: Core revision 20240322
> > > > > > > [    0.148345] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
> > > > > > > max_idle_ns: 133484882848 ns
> > > > > > > [    0.148362] APIC: Switch to symmetric I/O mode setup
> > > > > > > [    0.148364] DMAR-IR: This system BIOS has enabled interrupt remapping
> > > > > > >                   on a chipset that contains an erratum making that
> > > > > > >                   feature unstable.  To maintain system stability
> > > > > > >                   interrupt remapping is being disabled.  Please
> > > > > > >                   contact your BIOS vendor for an update
> > > > > > > [    0.148373] APIC: Switched APIC routing to: physical flat
> > > > > > > [    0.148941] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> > > > > > > [    0.168361] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
> > > > > > > 0x2686c8f140e, max_idle_ns: 440795237667 ns
> > > > > > > [    0.168371] Calibrating delay loop (skipped), value calculated using
> > > > > > > timer frequency.. 5345.55 BogoMIPS (lpj=10691104)
> > > > > > > [    0.168399] CPU0: Thermal monitoring enabled (TM1)
> > > > > > > [    0.168434] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
> > > > > > > [    0.168437] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> > > > > > > [    0.168442] process: using mwait in idle threads
> > > > > > > [    0.168445] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user
> > > > > > > pointer sanitization
> > > > > > > [    0.168448] Spectre V2 : Mitigation: Retpolines
> > > > > > > [    0.168450] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB
> > > > > > > on context switch
> > > > > > > [    0.168451] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> > > > > > > [    0.168453] Speculative Store Bypass: Vulnerable
> > > > > > > [    0.168456] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> > > > > > > [    0.168458] MMIO Stale Data: Unknown: No mitigations
> > > > > > > [    0.168461] x86/fpu: x87 FPU will use FXSAVE
> > > > > > > [    0.199521] Freeing SMP alternatives memory: 44K
> > > > > > > [    0.199542] pid_max: default: 32768 minimum: 301
> > > > > > > [    0.200572] LSM: initializing
> > > > > > > lsm=lockdown,capability,landlock,apparmor,ima,evm
> > > > > > > [    0.200869] landlock: Up and running.
> > > > > > > [    0.200909] AppArmor: AppArmor initialized
> > > > > > > [    0.201323] Mount-cache hash table entries: 32768 (order: 6, 262144
> > > > > > > bytes, linear)
> > > > > > > [    0.201357] Mountpoint-cache hash table entries: 32768 (order: 6, 262144
> > > > > > > bytes, linear)
> > > > > > > [    0.315223] smpboot: CPU0: Intel(R) Core(TM) i7 CPU 920  @ 2.67GHz
> > > > > > > (family: 0x6, model: 0x1a, stepping: 0x4)
> > > > > > > [    0.315671] Performance Events: PEBS fmt1+, Nehalem events, 16-deep LBR,
> > > > > > > Intel PMU driver.
> > > > > > > [    0.315695] core: CPU erratum AAJ80 worked around
> > > > > > > [    0.315697] ... version:                3
> > > > > > > [    0.315699] ... bit width:              48
> > > > > > > [    0.315700] ... generic registers:      4
> > > > > > > [    0.315702] ... value mask:             0000ffffffffffff
> > > > > > > [    0.315704] ... max period:             000000007fffffff
> > > > > > > [    0.315705] ... fixed-purpose events:   3
> > > > > > > [    0.315706] ... event mask:             000000070000000f
> > > > > > > [    0.315916] signal: max sigframe size: 1440
> > > > > > > [    0.315941] Estimated ratio of average max frequency by base frequency
> > > > > > > (times 1024): 1075
> > > > > > > [    0.316366] rcu: Hierarchical SRCU implementation.
> > > > > > > [    0.316366] rcu:     Max phase no-delay instances is 1000.
> > > > > > > [    0.316366] Timer migration: 2 hierarchy levels; 8 children per group; 2
> > > > > > > crossnode level
> > > > > > > [    0.316714] NMI watchdog: Enabled. Permanently consumes one hw-PMU
> > > > > > > counter.
> > > > > > > [    0.317011] smp: Bringing up secondary CPUs ...
> > > > > > > [    0.317232] smpboot: x86: Booting SMP configuration:
> > > > > > > [    0.317235] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6 #7
> > > > > > > [    0.328546] MDS CPU bug present and SMT on, data leak possible. See
> > > > > > > https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html  for more
> > > > > > > details.
> > > > > > > [    0.334368] smp: Brought up 1 node, 8 CPUs
> > > > > > > [    0.334368] smpboot: Total of 8 processors activated (42764.41 BogoMIPS)
> > > > > > > [    0.336514] Memory: 11491168K/12573812K available (20480K kernel code,
> > > > > > > 4237K rwdata, 7328K rodata, 4860K init, 5060K bss, 1068464K reserved, 0K
> > > > > > > cma-reserved)
> > > > > > > [    0.337198] devtmpfs: initialized
> > > > > > > [    0.337198] x86/mm: Memory block size: 128MB
> > > > > > > [    0.341390] ACPI: PM: Registering ACPI NVS region [mem
> > > > > > > 0xbf798000-0xbf7dbfff] (278528 bytes)
> > > > > > > [    0.341390] clocksource: jiffies: mask: 0xffffffff max_cycles:
> > > > > > > 0xffffffff, max_idle_ns: 7645041785100000 ns
> > > > > > > [    0.341390] futex hash table entries: 4096 (order: 6, 262144 bytes,
> > > > > > > linear)
> > > > > > > [    0.341390] pinctrl core: initialized pinctrl subsystem
> > > > > > > [    0.341390] PM: RTC time: 20:18:41, date: 2024-09-16
> > > > > > > [    0.342165] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> > > > > > > [    0.342551] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic
> > > > > > > allocations
> > > > > > > [    0.342790] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic
> > > > > > > allocations
> > > > > > > [    0.343038] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for
> > > > > > > atomic allocations
> > > > > > > [    0.343068] audit: initializing netlink subsys (disabled)
> > > > > > > [    0.343091] audit: type=2000 audit(1726517920.192:1): state=initialized
> > > > > > > audit_enabled=0 res=1
> > > > > > > [    0.344380] thermal_sys: Registered thermal governor 'fair_share'
> > > > > > > [    0.344382] thermal_sys: Registered thermal governor 'bang_bang'
> > > > > > > [    0.344384] thermal_sys: Registered thermal governor 'step_wise'
> > > > > > > [    0.344385] thermal_sys: Registered thermal governor 'user_space'
> > > > > > > [    0.344386] thermal_sys: Registered thermal governor 'power_allocator'
> > > > > > > [    0.344403] EISA bus registered
> > > > > > > [    0.344424] cpuidle: using governor ladder
> > > > > > > [    0.344429] cpuidle: using governor menu
> > > > > > > [    0.344500] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> > > > > > > [    0.344873] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for
> > > > > > > domain 0000 [bus 00-ff]
> > > > > > > [    0.344880] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not
> > > > > > > reserved)
> > > > > > > [    0.344882] PCI: Using configuration type 1 for base access
> > > > > > > [    0.344998] kprobes: kprobe jump-optimization is enabled. All kprobes are
> > > > > > > optimized if possible.
> > > > > > > [    0.347235] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> > > > > > > [    0.347235] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> > > > > > > [    0.351318] ACPI: Added _OSI(Module Device)
> > > > > > > [    0.351318] ACPI: Added _OSI(Processor Device)
> > > > > > > [    0.351318] ACPI: Added _OSI(3.0 _SCP Extensions)
> > > > > > > [    0.351318] ACPI: Added _OSI(Processor Aggregator Device)
> > > > > > > [    0.366412] ACPI: 2 ACPI AML tables successfully acquired and loaded
> > > > > > > [    0.401749] ACPI: Dynamic OEM Table Load:
> > > > > > > [    0.401749] ACPI: SSDT 0xFFFF9DD880974000 001C0C (v01 DpgPmm P001Ist
> > > > > > > 00000011 INTL 20060113)
> > > > > > > [    0.405367] ACPI: Interpreter enabled
> > > > > > > [    0.405389] ACPI: PM: (supports S0 S1 S3 S4 S5)
> > > > > > > [    0.405391] ACPI: Using IOAPIC for interrupt routing
> > > > > > > [    0.405439] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for
> > > > > > > domain 0000 [bus 00-ff]
> > > > > > > [    0.406832] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI
> > > > > > > motherboard resource
> > > > > > > [    0.406849] PCI: Using host bridge windows from ACPI; if necessary, use
> > > > > > > "pci=nocrs" and report a bug
> > > > > > > [    0.406851] PCI: Using E820 reservations for host bridge windows
> > > > > > > [    0.407073] ACPI: Enabled 13 GPEs in block 00 to 3F
> > > > > > > [    0.420700] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > > > > > > [    0.420710] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> > > > > > > ClockPM Segments MSI EDR HPX-Type3]
> > > > > > > [    0.420718] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug
> > > > > > > PME AER PCIeCapability LTR DPC]
> > > > > > > [    0.420720] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug
> > > > > > > SHPCHotplug PME AER PCIeCapability LTR DPC]
> > > > > > > [    0.420722] acpi PNP0A08:00: _OSC: platform retains control of PCIe
> > > > > > > features (AE_NOT_FOUND)
> > > > > > > [    0.421217] PCI host bridge to bus 0000:00
> > > > > > > [    0.421222] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7 window]
> > > > > > > [    0.421225] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
> > > > > > > [    0.421227] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff
> > > > > > > window]
> > > > > > > [    0.421229] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff
> > > > > > > window]
> > > > > > > [    0.421231] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff
> > > > > > > window]
> > > > > > > [    0.421233] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8ffff
> > > > > > > window]
> > > > > > > [    0.421235] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > > > > > [    0.421259] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000 PCIe
> > > > > > > Root Port
> > > > > > > [    0.421288] pci 0000:00:00.0: enabling Extended Tags
> > > > > > > [    0.421332] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.421435] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.421452] pci 0000:00:01.0: PCI bridge to [bus 01]
> > > > > > > [    0.421469] pci 0000:00:01.0: enabling Extended Tags
> > > > > > > [    0.421514] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.421651] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.421673] pci 0000:00:03.0: PCI bridge to [bus 02-04]
> > > > > > > [    0.421677] pci 0000:00:03.0:   bridge window [io 0xa000-0xafff]
> > > > > > > [    0.421680] pci 0000:00:03.0:   bridge window [mem 0xfb600000-0xfb8fffff]
> > > > > > > [    0.421688] pci 0000:00:03.0:   bridge window [mem 0xcfe00000-0xdfffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.421695] pci 0000:00:03.0: enabling Extended Tags
> > > > > > > [    0.421740] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.421868] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.421885] pci 0000:00:07.0: PCI bridge to [bus 05]
> > > > > > > [    0.421903] pci 0000:00:07.0: enabling Extended Tags
> > > > > > > [    0.421947] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.422074] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000 PCIe
> > > > > > > Root Complex Integrated Endpoint
> > > > > > > [    0.422186] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000 PCIe
> > > > > > > Root Complex Integrated Endpoint
> > > > > > > [    0.422294] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000 PCIe
> > > > > > > Root Complex Integrated Endpoint
> > > > > > > [    0.422397] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.422490] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.422531] pci 0000:00:1a.0: BAR 4 [io  0x9800-0x981f]
> > > > > > > [    0.422653] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.422694] pci 0000:00:1a.1: BAR 4 [io  0x9880-0x989f]
> > > > > > > [    0.422825] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.422865] pci 0000:00:1a.2: BAR 4 [io  0x9c00-0x9c1f]
> > > > > > > [    0.423001] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.423018] pci 0000:00:1a.7: BAR 0 [mem 0xfb5ff000-0xfb5ff3ff]
> > > > > > > [    0.423099] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.423200] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300 PCIe
> > > > > > > Root Complex Integrated Endpoint
> > > > > > > [    0.423218] pci 0000:00:1b.0: BAR 0 [mem 0xfb5f8000-0xfb5fbfff 64bit]
> > > > > > > [    0.423294] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.423384] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.423410] pci 0000:00:1c.0: PCI bridge to [bus 0a]
> > > > > > > [    0.423424] pci 0000:00:1c.0:   bridge window [mem 0xfaf00000-0xfaffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.423478] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.423599] pci 0000:00:1c.1: [8086:3a42] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.423626] pci 0000:00:1c.1: PCI bridge to [bus 09]
> > > > > > > [    0.423632] pci 0000:00:1c.1:   bridge window [mem 0xfbc00000-0xfbdfffff]
> > > > > > > [    0.423694] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.423824] pci 0000:00:1c.2: [8086:3a44] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.423850] pci 0000:00:1c.2: PCI bridge to [bus 08]
> > > > > > > [    0.423855] pci 0000:00:1c.2:   bridge window [io 0xd000-0xdfff]
> > > > > > > [    0.423858] pci 0000:00:1c.2:   bridge window [mem 0xfbb00000-0xfbbfffff]
> > > > > > > [    0.423919] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.424038] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.424064] pci 0000:00:1c.4: PCI bridge to [bus 07]
> > > > > > > [    0.424069] pci 0000:00:1c.4:   bridge window [io 0xc000-0xcfff]
> > > > > > > [    0.424072] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
> > > > > > > [    0.424133] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.424253] pci 0000:00:1c.5: [8086:3a4a] type 01 class 0x060400 PCIe
> > > > > > > Root Port
> > > > > > > [    0.424279] pci 0000:00:1c.5: PCI bridge to [bus 06]
> > > > > > > [    0.424284] pci 0000:00:1c.5:   bridge window [io 0xb000-0xbfff]
> > > > > > > [    0.424287] pci 0000:00:1c.5:   bridge window [mem 0xfb900000-0xfb9fffff]
> > > > > > > [    0.424348] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.424477] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.424517] pci 0000:00:1d.0: BAR 4 [io  0x9080-0x909f]
> > > > > > > [    0.424643] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.424684] pci 0000:00:1d.1: BAR 4 [io  0x9400-0x941f]
> > > > > > > [    0.424809] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.424851] pci 0000:00:1d.2: BAR 4 [io  0x9480-0x949f]
> > > > > > > [    0.424984] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.425001] pci 0000:00:1d.7: BAR 0 [mem 0xfb5fe000-0xfb5fe3ff]
> > > > > > > [    0.425082] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.425178] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
> > > > > > > conventional PCI bridge
> > > > > > > [    0.425203] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
> > > > > > > [    0.425208] pci 0000:00:1e.0:   bridge window [io 0xe000-0xefff]
> > > > > > > [    0.425211] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
> > > > > > > [    0.425335] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.425412] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6
> > > > > > > ACPI/GPIO/TCO
> > > > > > > [    0.425417] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6
> > > > > > > GPIO
> > > > > > > [    0.425420] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294
> > > > > > > (mask 0003)
> > > > > > > [    0.425425] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700
> > > > > > > (mask 001f)
> > > > > > > [    0.425575] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.425589] pci 0000:00:1f.2: BAR 0 [io  0x8c00-0x8c07]
> > > > > > > [    0.425596] pci 0000:00:1f.2: BAR 1 [io  0x8880-0x8883]
> > > > > > > [    0.425604] pci 0000:00:1f.2: BAR 2 [io  0x8800-0x8807]
> > > > > > > [    0.425611] pci 0000:00:1f.2: BAR 3 [io  0x8480-0x8483]
> > > > > > > [    0.425618] pci 0000:00:1f.2: BAR 4 [io  0x8400-0x841f]
> > > > > > > [    0.425625] pci 0000:00:1f.2: BAR 5 [mem 0xfb5fc000-0xfb5fc7ff]
> > > > > > > [    0.425666] pci 0000:00:1f.2: PME# supported from D3hot
> > > > > > > [    0.425760] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.425777] pci 0000:00:1f.3: BAR 0 [mem 0xfb5fd000-0xfb5fd0ff 64bit]
> > > > > > > [    0.425797] pci 0000:00:1f.3: BAR 4 [io  0x0400-0x041f]
> > > > > > > [    0.425902] pci 0000:00:01.0: PCI bridge to [bus 01]
> > > > > > > [    0.425962] pci 0000:02:00.0: [1002:1478] type 01 class 0x060400 PCIe
> > > > > > > Switch Upstream Port
> > > > > > > [    0.425977] pci 0000:02:00.0: BAR 0 [mem 0xfb6fc000-0xfb6fffff]
> > > > > > > [    0.425992] pci 0000:02:00.0: PCI bridge to [bus 03-04]
> > > > > > > [    0.425999] pci 0000:02:00.0:   bridge window [io 0xa000-0xafff]
> > > > > > > [    0.426002] pci 0000:02:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
> > > > > > > [    0.426012] pci 0000:02:00.0:   bridge window [mem 0xcfe00000-0xdfffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.426097] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.426163] pci 0000:02:00.0: 16.000 Gb/s available PCIe bandwidth,
> > > > > > > limited by 5.0 GT/s PCIe x4 link at 0000:00:03.0 (capable of 63.012 Gb/s
> > > > > > > with 16.0 GT/s PCIe x4 link)
> > > > > > > [    0.436388] pci 0000:00:03.0: PCI bridge to [bus 02-04]
> > > > > > > [    0.436467] pci 0000:03:00.0: [1002:1479] type 01 class 0x060400 PCIe
> > > > > > > Switch Downstream Port
> > > > > > > [    0.436495] pci 0000:03:00.0: PCI bridge to [bus 04]
> > > > > > > [    0.436501] pci 0000:03:00.0:   bridge window [io 0xa000-0xafff]
> > > > > > > [    0.436505] pci 0000:03:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
> > > > > > > [    0.436515] pci 0000:03:00.0:   bridge window [mem 0xcfe00000-0xdfffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.436600] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> > > > > > > [    0.436763] pci 0000:02:00.0: PCI bridge to [bus 03-04]
> > > > > > > [    0.436832] pci 0000:04:00.0: [1002:743f] type 00 class 0x030000 PCIe
> > > > > > > Legacy Endpoint
> > > > > > > [    0.436852] pci 0000:04:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit
> > > > > > > pref]
> > > > > > > [    0.436864] pci 0000:04:00.0: BAR 2 [mem 0xcfe00000-0xcfffffff 64bit
> > > > > > > pref]
> > > > > > > [    0.436872] pci 0000:04:00.0: BAR 4 [io  0xa000-0xa0ff]
> > > > > > > [    0.436880] pci 0000:04:00.0: BAR 5 [mem 0xfb700000-0xfb7fffff]
> > > > > > > [    0.436888] pci 0000:04:00.0: ROM [mem 0xfb8c0000-0xfb8dffff pref]
> > > > > > > [    0.436925] pci 0000:04:00.0: Video device with shadowed ROM at [mem
> > > > > > > 0x000c0000-0x000dffff]
> > > > > > > [    0.436985] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
> > > > > > > [    0.437058] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth,
> > > > > > > limited by 5.0 GT/s PCIe x4 link at 0000:00:03.0 (capable of 252.048 Gb/s
> > > > > > > with 16.0 GT/s PCIe x16 link)
> > > > > > > [    0.437158] pci 0000:04:00.1: [1002:ab28] type 00 class 0x040300 PCIe
> > > > > > > Legacy Endpoint
> > > > > > > [    0.437173] pci 0000:04:00.1: BAR 0 [mem 0xfb8fc000-0xfb8fffff]
> > > > > > > [    0.437271] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
> > > > > > > [    0.437411] pci 0000:03:00.0: PCI bridge to [bus 04]
> > > > > > > [    0.437472] pci 0000:00:07.0: PCI bridge to [bus 05]
> > > > > > > [    0.437519] pci 0000:00:1c.0: PCI bridge to [bus 0a]
> > > > > > > [    0.437590] pci 0000:09:00.0: [14f1:8880] type 00 class 0x040000 PCIe
> > > > > > > Endpoint
> > > > > > > [    0.437623] pci 0000:09:00.0: BAR 0 [mem 0xfbc00000-0xfbdfffff 64bit]
> > > > > > > [    0.437793] pci 0000:09:00.0: supports D1 D2
> > > > > > > [    0.437794] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot
> > > > > > > [    0.437927] pci 0000:09:00.0: disabling ASPM on pre-1.1 PCIe device.  You
> > > > > > > can enable it with 'pcie_aspm=force'
> > > > > > > [    0.437941] pci 0000:00:1c.1: PCI bridge to [bus 09]
> > > > > > > [    0.438009] pci 0000:08:00.0: [11ab:4364] type 00 class 0x020000 PCIe
> > > > > > > Legacy Endpoint
> > > > > > > [    0.438036] pci 0000:08:00.0: BAR 0 [mem 0xfbbfc000-0xfbbfffff 64bit]
> > > > > > > [    0.438048] pci 0000:08:00.0: BAR 2 [io  0xd800-0xd8ff]
> > > > > > > [    0.438088] pci 0000:08:00.0: ROM [mem 0xfbbc0000-0xfbbdffff pref]
> > > > > > > [    0.438159] pci 0000:08:00.0: supports D1 D2
> > > > > > > [    0.438161] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > > > > > [    0.438257] pci 0000:00:1c.2: ASPM: current common clock configuration is
> > > > > > > inconsistent, reconfiguring
> > > > > > > [    0.448394] pci 0000:00:1c.2: PCI bridge to [bus 08]
> > > > > > > [    0.448486] pci 0000:07:00.0: [11ab:6121] type 00 class 0x01018f PCIe
> > > > > > > Legacy Endpoint
> > > > > > > [    0.448506] pci 0000:07:00.0: BAR 0 [io  0xcc00-0xcc07]
> > > > > > > [    0.448518] pci 0000:07:00.0: BAR 1 [io  0xc880-0xc883]
> > > > > > > [    0.448529] pci 0000:07:00.0: BAR 2 [io  0xc800-0xc807]
> > > > > > > [    0.448540] pci 0000:07:00.0: BAR 3 [io  0xc480-0xc483]
> > > > > > > [    0.448551] pci 0000:07:00.0: BAR 4 [io  0xc400-0xc40f]
> > > > > > > [    0.448562] pci 0000:07:00.0: BAR 5 [mem 0xfbaffc00-0xfbafffff]
> > > > > > > [    0.448636] pci 0000:07:00.0: supports D1
> > > > > > > [    0.448638] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
> > > > > > > [    0.448727] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  You
> > > > > > > can enable it with 'pcie_aspm=force'
> > > > > > > [    0.448739] pci 0000:00:1c.4: PCI bridge to [bus 07]
> > > > > > > [    0.448811] pci 0000:06:00.0: [11ab:4364] type 00 class 0x020000 PCIe
> > > > > > > Legacy Endpoint
> > > > > > > [    0.448838] pci 0000:06:00.0: BAR 0 [mem 0xfb9fc000-0xfb9fffff 64bit]
> > > > > > > [    0.448850] pci 0000:06:00.0: BAR 2 [io  0xb800-0xb8ff]
> > > > > > > [    0.448891] pci 0000:06:00.0: ROM [mem 0xfb9c0000-0xfb9dffff pref]
> > > > > > > [    0.448963] pci 0000:06:00.0: supports D1 D2
> > > > > > > [    0.448965] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > > > > > [    0.449068] pci 0000:00:1c.5: ASPM: current common clock configuration is
> > > > > > > inconsistent, reconfiguring
> > > > > > > [    0.460394] pci 0000:00:1c.5: PCI bridge to [bus 06]
> > > > > > > [    0.460427] pci_bus 0000:0b: extended config space not accessible
> > > > > > > [    0.460468] pci 0000:0b:02.0: [1106:3044] type 00 class 0x0c0010
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.460485] pci 0000:0b:02.0: BAR 0 [mem 0xfbeff000-0xfbeff7ff]
> > > > > > > [    0.460495] pci 0000:0b:02.0: BAR 1 [io  0xec00-0xec7f]
> > > > > > > [    0.460565] pci 0000:0b:02.0: supports D2
> > > > > > > [    0.460567] pci 0000:0b:02.0: PME# supported from D2 D3hot D3cold
> > > > > > > [    0.460650] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
> > > > > > > [    0.460660] pci 0000:00:1e.0:   bridge window [io 0x0000-0x0cf7 window]
> > > > > > > (subtractive decode)
> > > > > > > [    0.460662] pci 0000:00:1e.0:   bridge window [io 0x0d00-0xffff window]
> > > > > > > (subtractive decode)
> > > > > > > [    0.460664] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff
> > > > > > > window] (subtractive decode)
> > > > > > > [    0.460666] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff
> > > > > > > window] (subtractive decode)
> > > > > > > [    0.460668] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff
> > > > > > > window] (subtractive decode)
> > > > > > > [    0.460670] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff
> > > > > > > window] (subtractive decode)
> > > > > > > [    0.461561] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
> > > > > > > [    0.461631] ACPI: PCI: Interrupt link LNKB configured for IRQ 5
> > > > > > > [    0.461700] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> > > > > > > [    0.461768] ACPI: PCI: Interrupt link LNKD configured for IRQ 14
> > > > > > > [    0.461835] ACPI: PCI: Interrupt link LNKE configured for IRQ 15
> > > > > > > [    0.461903] ACPI: PCI: Interrupt link LNKF configured for IRQ 3
> > > > > > > [    0.461971] ACPI: PCI: Interrupt link LNKG configured for IRQ 7
> > > > > > > [    0.462039] ACPI: PCI: Interrupt link LNKH configured for IRQ 4
> > > > > > > [    0.462216] iommu: Default domain type: Translated
> > > > > > > [    0.462216] iommu: DMA domain TLB invalidation policy: lazy mode
> > > > > > > [    0.462216] SCSI subsystem initialized
> > > > > > > [    0.462216] libata version 3.00 loaded.
> > > > > > > [    0.462216] ACPI: bus type USB registered
> > > > > > > [    0.462216] usbcore: registered new interface driver usbfs
> > > > > > > [    0.462216] usbcore: registered new interface driver hub
> > > > > > > [    0.462216] usbcore: registered new device driver usb
> > > > > > > [    0.462216] pps_core: LinuxPPS API ver. 1 registered
> > > > > > > [    0.462216] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
> > > > > > > Giometti<giometti@linux.it>
> > > > > > > [    0.462216] PTP clock support registered
> > > > > > > [    0.462216] EDAC MC: Ver: 3.0.0
> > > > > > > [    0.462216] NetLabel: Initializing
> > > > > > > [    0.462216] NetLabel:  domain hash size = 128
> > > > > > > [    0.462216] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> > > > > > > [    0.462216] NetLabel:  unlabeled traffic allowed by default
> > > > > > > [    0.462216] PCI: Using ACPI for IRQ routing
> > > > > > > [    0.468990] PCI: Discovered peer bus ff
> > > > > > > [    0.468992] PCI: root bus ff: using default resources
> > > > > > > [    0.468994] PCI: Probing PCI hardware (bus ff)
> > > > > > > [    0.469021] PCI host bridge to bus 0000:ff
> > > > > > > [    0.469023] pci_bus 0000:ff: root bus resource [io 0x0000-0xffff]
> > > > > > > [    0.469026] pci_bus 0000:ff: root bus resource [mem
> > > > > > > 0x00000000-0xfffffffff]
> > > > > > > [    0.469028] pci_bus 0000:ff: No busn resource found for root bus, will
> > > > > > > use [bus ff-ff]
> > > > > > > [    0.469030] pci_bus 0000:ff: busn_res: can not insert [bus ff] under
> > > > > > > domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
> > > > > > > [    0.469038] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469094] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469145] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469192] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469241] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469290] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469343] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469391] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469441] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469488] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469535] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469585] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469632] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469679] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469731] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469782] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469829] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469875] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469925] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000
> > > > > > > conventional PCI endpoint
> > > > > > > [    0.469981] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
> > > > > > > [    0.469984] pci_bus 0000:ff: busn_res: can not insert [bus ff] under
> > > > > > > domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
> > > > > > > [    0.469992] PCI: pci_cache_line_size set to 64 bytes
> > > > > > > [    0.470083] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
> > > > > > > [    0.470085] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
> > > > > > > [    0.470108] pci 0000:04:00.0: vgaarb: setting as boot VGA device
> > > > > > > [    0.470108] pci 0000:04:00.0: vgaarb: bridge control possible
> > > > > > > [    0.470108] pci 0000:04:00.0: vgaarb: VGA device added:
> > > > > > > decodes=io+mem,owns=io+mem,locks=none
> > > > > > > [    0.470108] vgaarb: loaded
> > > > > > > [    0.470108] hpet: 4 channels of 0 reserved for per-cpu timers
> > > > > > > [    0.470108] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> > > > > > > [    0.470108] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
> > > > > > > [    0.472412] clocksource: Switched to clocksource tsc-early
> > > > > > > [    0.474123] VFS: Disk quotas dquot_6.6.0
> > > > > > > [    0.474178] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
> > > > > > > bytes)
> > > > > > > [    0.474353] AppArmor: AppArmor Filesystem Enabled
> > > > > > > [    0.474372] pnp: PnP ACPI init
> > > > > > > [    0.474452] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
> > > > > > > [    0.474456] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
> > > > > > > [    0.474458] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
> > > > > > > [    0.474460] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
> > > > > > > [    0.474462] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be
> > > > > > > reserved
> > > > > > > [    0.474465] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
> > > > > > > [    0.474787] system 00:02: [io  0x0290-0x029f] has been reserved
> > > > > > > [    0.475064] system 00:03: [io  0x04d0-0x04d1] has been reserved
> > > > > > > [    0.475068] system 00:03: [io  0x0800-0x087f] has been reserved
> > > > > > > [    0.475070] system 00:03: [io  0x0500-0x057f] could not be reserved
> > > > > > > [    0.475072] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
> > > > > > > [    0.475075] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
> > > > > > > [    0.475077] system 00:03: [mem 0xfed40000-0xfed8ffff] has been reserved
> > > > > > > [    0.475240] system 00:04: [mem 0xffc00000-0xffdfffff] has been reserved
> > > > > > > [    0.475414] system 00:05: [mem 0xfec00000-0xfec00fff] could not be
> > > > > > > reserved
> > > > > > > [    0.475418] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
> > > > > > > [    0.475547] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
> > > > > > > [    0.475756] pnp 00:07: disabling [mem 0x000c0000-0x000cffff] because it
> > > > > > > overlaps 0000:04:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
> > > > > > > [    0.475794] system 00:07: [mem 0x00000000-0x0009ffff] could not be
> > > > > > > reserved
> > > > > > > [    0.475797] system 00:07: [mem 0x000e0000-0x000fffff] could not be
> > > > > > > reserved
> > > > > > > [    0.475799] system 00:07: [mem 0x00100000-0xbfffffff] could not be
> > > > > > > reserved
> > > > > > > [    0.475801] system 00:07: [mem 0xfed90000-0xffffffff] could not be
> > > > > > > reserved
> > > > > > > [    0.475968] pnp: PnP ACPI: found 8 devices
> > > > > > > [    0.482412] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
> > > > > > > max_idle_ns: 2085701024 ns
> > > > > > > [    0.482668] NET: Registered PF_INET protocol family
> > > > > > > [    0.482922] IP idents hash table entries: 262144 (order: 9, 2097152
> > > > > > > bytes, linear)
> > > > > > > [    0.487040] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,
> > > > > > > 131072 bytes, linear)
> > > > > > > [    0.487090] Table-perturb hash table entries: 65536 (order: 6, 262144
> > > > > > > bytes, linear)
> > > > > > > [    0.487211] TCP established hash table entries: 131072 (order: 8, 1048576
> > > > > > > bytes, linear)
> > > > > > > [    0.487622] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,
> > > > > > > linear)
> > > > > > > [    0.487923] TCP: Hash tables configured (established 131072 bind 65536)
> > > > > > > [    0.488158] MPTCP token hash table entries: 16384 (order: 6, 393216
> > > > > > > bytes, linear)
> > > > > > > [    0.488251] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> > > > > > > [    0.488324] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes,
> > > > > > > linear)
> > > > > > > [    0.488454] NET: Registered PF_UNIX/PF_LOCAL protocol family
> > > > > > > [    0.488463] NET: Registered PF_XDP protocol family
> > > > > > > [    0.488480] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus
> > > > > > > 0a] add_size 1000
> > > > > > > [    0.488484] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff]
> > > > > > > to [bus 0a] add_size 200000 add_align 100000
> > > > > > > [    0.488488] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to [bus
> > > > > > > 09] add_size 1000
> > > > > > > [    0.488491] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff
> > > > > > > 64bit pref] to [bus 09] add_size 200000 add_align 100000
> > > > > > > [    0.488494] pci 0000:00:1c.2: bridge window [mem 0x00100000-0x000fffff
> > > > > > > 64bit pref] to [bus 08] add_size 200000 add_align 100000
> > > > > > > [    0.488497] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff
> > > > > > > 64bit pref] to [bus 07] add_size 200000 add_align 100000
> > > > > > > [    0.488500] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff
> > > > > > > 64bit pref] to [bus 06] add_size 200000 add_align 100000
> > > > > > > [    0.488517] pci 0000:00:1c.0: bridge window [mem 0xc0000000-0xc01fffff]:
> > > > > > > assigned
> > > > > > > [    0.488520] pci 0000:00:1c.1: bridge window [mem 0xc0200000-0xc03fffff
> > > > > > > 64bit pref]: assigned
> > > > > > > [    0.488524] pci 0000:00:1c.2: bridge window [mem 0xc0400000-0xc05fffff
> > > > > > > 64bit pref]: assigned
> > > > > > > [    0.488526] pci 0000:00:1c.4: bridge window [mem 0xc0600000-0xc07fffff
> > > > > > > 64bit pref]: assigned
> > > > > > > [    0.488529] pci 0000:00:1c.5: bridge window [mem 0xc0800000-0xc09fffff
> > > > > > > 64bit pref]: assigned
> > > > > > > [    0.488532] pci 0000:00:1c.0: bridge window [io 0x1000-0x1fff]: assigned
> > > > > > > [    0.488535] pci 0000:00:1c.1: bridge window [io 0x2000-0x2fff]: assigned
> > > > > > > [    0.488538] pci 0000:00:01.0: PCI bridge to [bus 01]
> > > > > > > [    0.488548] pci 0000:03:00.0: PCI bridge to [bus 04]
> > > > > > > [    0.488550] pci 0000:03:00.0:   bridge window [io 0xa000-0xafff]
> > > > > > > [    0.488555] pci 0000:03:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
> > > > > > > [    0.488559] pci 0000:03:00.0:   bridge window [mem 0xcfe00000-0xdfffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488564] pci 0000:02:00.0: PCI bridge to [bus 03-04]
> > > > > > > [    0.488567] pci 0000:02:00.0:   bridge window [io 0xa000-0xafff]
> > > > > > > [    0.488571] pci 0000:02:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
> > > > > > > [    0.488575] pci 0000:02:00.0:   bridge window [mem 0xcfe00000-0xdfffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488580] pci 0000:00:03.0: PCI bridge to [bus 02-04]
> > > > > > > [    0.488583] pci 0000:00:03.0:   bridge window [io 0xa000-0xafff]
> > > > > > > [    0.488586] pci 0000:00:03.0:   bridge window [mem 0xfb600000-0xfb8fffff]
> > > > > > > [    0.488590] pci 0000:00:03.0:   bridge window [mem 0xcfe00000-0xdfffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488594] pci 0000:00:07.0: PCI bridge to [bus 05]
> > > > > > > [    0.488603] pci 0000:00:1c.0: PCI bridge to [bus 0a]
> > > > > > > [    0.488605] pci 0000:00:1c.0:   bridge window [io 0x1000-0x1fff]
> > > > > > > [    0.488609] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff]
> > > > > > > [    0.488612] pci 0000:00:1c.0:   bridge window [mem 0xfaf00000-0xfaffffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488618] pci 0000:00:1c.1: PCI bridge to [bus 09]
> > > > > > > [    0.488620] pci 0000:00:1c.1:   bridge window [io 0x2000-0x2fff]
> > > > > > > [    0.488624] pci 0000:00:1c.1:   bridge window [mem 0xfbc00000-0xfbdfffff]
> > > > > > > [    0.488628] pci 0000:00:1c.1:   bridge window [mem 0xc0200000-0xc03fffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488633] pci 0000:00:1c.2: PCI bridge to [bus 08]
> > > > > > > [    0.488635] pci 0000:00:1c.2:   bridge window [io 0xd000-0xdfff]
> > > > > > > [    0.488639] pci 0000:00:1c.2:   bridge window [mem 0xfbb00000-0xfbbfffff]
> > > > > > > [    0.488643] pci 0000:00:1c.2:   bridge window [mem 0xc0400000-0xc05fffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488648] pci 0000:00:1c.4: PCI bridge to [bus 07]
> > > > > > > [    0.488650] pci 0000:00:1c.4:   bridge window [io 0xc000-0xcfff]
> > > > > > > [    0.488654] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
> > > > > > > [    0.488658] pci 0000:00:1c.4:   bridge window [mem 0xc0600000-0xc07fffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488663] pci 0000:00:1c.5: PCI bridge to [bus 06]
> > > > > > > [    0.488665] pci 0000:00:1c.5:   bridge window [io 0xb000-0xbfff]
> > > > > > > [    0.488669] pci 0000:00:1c.5:   bridge window [mem 0xfb900000-0xfb9fffff]
> > > > > > > [    0.488673] pci 0000:00:1c.5:   bridge window [mem 0xc0800000-0xc09fffff
> > > > > > > 64bit pref]
> > > > > > > [    0.488678] pci 0000:00:1e.0: PCI bridge to [bus 0b]
> > > > > > > [    0.488681] pci 0000:00:1e.0:   bridge window [io 0xe000-0xefff]
> > > > > > > [    0.488685] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
> > > > > > > [    0.488692] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> > > > > > > [    0.488694] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> > > > > > > [    0.488696] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
> > > > > > > window]
> > > > > > > [    0.488698] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff
> > > > > > > window]
> > > > > > > [    0.488700] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff
> > > > > > > window]
> > > > > > > [    0.488702] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff
> > > > > > > window]
> > > > > > > [    0.488704] pci_bus 0000:02: resource 0 [io  0xa000-0xafff]
> > > > > > > [    0.488705] pci_bus 0000:02: resource 1 [mem 0xfb600000-0xfb8fffff]
> > > > > > > [    0.488707] pci_bus 0000:02: resource 2 [mem 0xcfe00000-0xdfffffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488709] pci_bus 0000:03: resource 0 [io  0xa000-0xafff]
> > > > > > > [    0.488711] pci_bus 0000:03: resource 1 [mem 0xfb700000-0xfb8fffff]
> > > > > > > [    0.488712] pci_bus 0000:03: resource 2 [mem 0xcfe00000-0xdfffffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488714] pci_bus 0000:04: resource 0 [io  0xa000-0xafff]
> > > > > > > [    0.488716] pci_bus 0000:04: resource 1 [mem 0xfb700000-0xfb8fffff]
> > > > > > > [    0.488718] pci_bus 0000:04: resource 2 [mem 0xcfe00000-0xdfffffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488720] pci_bus 0000:0a: resource 0 [io  0x1000-0x1fff]
> > > > > > > [    0.488722] pci_bus 0000:0a: resource 1 [mem 0xc0000000-0xc01fffff]
> > > > > > > [    0.488723] pci_bus 0000:0a: resource 2 [mem 0xfaf00000-0xfaffffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488725] pci_bus 0000:09: resource 0 [io  0x2000-0x2fff]
> > > > > > > [    0.488727] pci_bus 0000:09: resource 1 [mem 0xfbc00000-0xfbdfffff]
> > > > > > > [    0.488728] pci_bus 0000:09: resource 2 [mem 0xc0200000-0xc03fffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488730] pci_bus 0000:08: resource 0 [io  0xd000-0xdfff]
> > > > > > > [    0.488732] pci_bus 0000:08: resource 1 [mem 0xfbb00000-0xfbbfffff]
> > > > > > > [    0.488734] pci_bus 0000:08: resource 2 [mem 0xc0400000-0xc05fffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488736] pci_bus 0000:07: resource 0 [io  0xc000-0xcfff]
> > > > > > > [    0.488737] pci_bus 0000:07: resource 1 [mem 0xfba00000-0xfbafffff]
> > > > > > > [    0.488739] pci_bus 0000:07: resource 2 [mem 0xc0600000-0xc07fffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488741] pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
> > > > > > > [    0.488743] pci_bus 0000:06: resource 1 [mem 0xfb900000-0xfb9fffff]
> > > > > > > [    0.488744] pci_bus 0000:06: resource 2 [mem 0xc0800000-0xc09fffff 64bit
> > > > > > > pref]
> > > > > > > [    0.488746] pci_bus 0000:0b: resource 0 [io  0xe000-0xefff]
> > > > > > > [    0.488748] pci_bus 0000:0b: resource 1 [mem 0xfbe00000-0xfbefffff]
> > > > > > > [    0.488750] pci_bus 0000:0b: resource 4 [io  0x0000-0x0cf7 window]
> > > > > > > [    0.488751] pci_bus 0000:0b: resource 5 [io  0x0d00-0xffff window]
> > > > > > > [    0.488753] pci_bus 0000:0b: resource 6 [mem 0x000a0000-0x000bffff
> > > > > > > window]
> > > > > > > [    0.488755] pci_bus 0000:0b: resource 7 [mem 0x000d0000-0x000dffff
> > > > > > > window]
> > > > > > > [    0.488757] pci_bus 0000:0b: resource 8 [mem 0xc0000000-0xdfffffff
> > > > > > > window]
> > > > > > > [    0.488758] pci_bus 0000:0b: resource 9 [mem 0xf0000000-0xfed8ffff
> > > > > > > window]
> > > > > > > [    0.488836] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
> > > > > > > [    0.488838] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
> > > > > > > [    0.490705] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
> > > > > > > [    0.490763] PCI: CLS 256 bytes, default 64
> > > > > > > [    0.490837] DMAR: Host address width 39
> > > > > > > [    0.490840] DMAR: DRHD base: 0x000000fbfff000 flags: 0x0
> > > > > > > [    0.490855] DMAR: dmar0: reg_base_addr fbfff000 ver 1:0 cap
> > > > > > > c9008010e60262 ecap f0207a
> > > > > > > [    0.490859] DMAR: DRHD base: 0x000000fbffe000 flags: 0x1
> > > > > > > [    0.490868] DMAR: dmar1: reg_base_addr fbffe000 ver 1:0 cap
> > > > > > > c90780106f0462 ecap f020fe
> > > > > > > [    0.490872] DMAR: RMRR base: 0x000000000ec000 end: 0x000000000effff
> > > > > > > [    0.490874] DMAR: RMRR base: 0x000000bf7dc000 end: 0x000000bf7dbfff
> > > > > > > [    0.490876] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR
> > > > > > > [0x00000000bf7dc000-0x00000000bf7dbfff]
> > > > > > >                   BIOS vendor: American Megatrends Inc.; Ver: 2209 ; Product
> > > > > > > Version: System Version
> > > > > > > [    0.490885] DMAR: ATSR flags: 0x0
> > > > > > > [    0.490916] Trying to unpack rootfs image as initramfs...
> > > > > > > [    0.490924] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> > > > > > > [    0.490926] software IO TLB: mapped [mem
> > > > > > > 0x00000000bb780000-0x00000000bf780000] (64MB)
> > > > > > > [    0.498853] Initialise system trusted keyrings
> > > > > > > [    0.498871] Key type blacklist registered
> > > > > > > [    0.498929] workingset: timestamp_bits=36 max_order=22 bucket_order=0
> > > > > > > [    0.498939] zbud: loaded
> > > > > > > [    0.500605] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > > > > > > [    0.500783] fuse: init (API version 7.40)
> > > > > > > [    0.501317] integrity: Platform Keyring initialized
> > > > > > > [    0.518817] Key type asymmetric registered
> > > > > > > [    0.518823] Asymmetric key parser 'x509' registered
> > > > > > > [    0.518900] Block layer SCSI generic (bsg) driver version 0.4 loaded
> > > > > > > (major 243)
> > > > > > > [    0.518995] io scheduler mq-deadline registered
> > > > > > > [    0.519607] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
> > > > > > > [    0.519816] pcieport 0000:00:1c.1: enabling device (0106 -> 0107)
> > > > > > > [    0.520733] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > > > > > > [    0.520780] Driver vt8623fb not loading because of nomodeset parameter
> > > > > > > [    0.521646] input: Power Button as
> > > > > > > /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> > > > > > > [    0.521681] ACPI: button: Power Button [PWRB]
> > > > > > > [    0.521720] input: Power Button as
> > > > > > > /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> > > > > > > [    0.521846] ACPI: button: Power Button [PWRF]
> > > > > > > [    0.523498] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> > > > > > > [    0.527493] Linux agpgart interface v0.103
> > > > > > > [    0.532004] loop: module loaded
> > > > > > > [    0.532510] tun: Universal TUN/TAP device driver, 1.6
> > > > > > > [    0.532598] PPP generic driver version 2.4.2
> > > > > > > [    0.532913] VFIO - User Level meta-driver version: 0.3
> > > > > > > [    0.533261] uhci_hcd 0000:00:1a.0: UHCI Host Controller
> > > > > > > [    0.533272] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus
> > > > > > > number 1
> > > > > > > [    0.533282] uhci_hcd 0000:00:1a.0: detected 2 ports
> > > > > > > [    0.533318] uhci_hcd 0000:00:1a.0: irq 16, io port 0x00009800
> > > > > > > [    0.533385] usb usb1: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0001, bcdDevice= 6.11
> > > > > > > [    0.533388] usb usb1: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.533390] usb usb1: Product: UHCI Host Controller
> > > > > > > [    0.533392] usb usb1: Manufacturer: Linux 6.11.0 uhci_hcd
> > > > > > > [    0.533393] usb usb1: SerialNumber: 0000:00:1a.0
> > > > > > > [    0.533563] hub 1-0:1.0: USB hub found
> > > > > > > [    0.533572] hub 1-0:1.0: 2 ports detected
> > > > > > > [    0.533852] ehci-pci 0000:00:1a.7: EHCI Host Controller
> > > > > > > [    0.533861] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus
> > > > > > > number 2
> > > > > > > [    0.533874] ehci-pci 0000:00:1a.7: debug port 1
> > > > > > > [    0.537796] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfb5ff000
> > > > > > > [    0.553037] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
> > > > > > > [    0.553115] usb usb2: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0002, bcdDevice= 6.11
> > > > > > > [    0.553119] usb usb2: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.553121] usb usb2: Product: EHCI Host Controller
> > > > > > > [    0.553122] usb usb2: Manufacturer: Linux 6.11.0 ehci_hcd
> > > > > > > [    0.553124] usb usb2: SerialNumber: 0000:00:1a.7
> > > > > > > [    0.553411] hub 2-0:1.0: USB hub found
> > > > > > > [    0.553424] hub 2-0:1.0: 6 ports detected
> > > > > > > [    0.581085] hub 1-0:1.0: USB hub found
> > > > > > > [    0.581097] hub 1-0:1.0: 2 ports detected
> > > > > > > [    0.581279] ehci-pci 0000:00:1d.7: EHCI Host Controller
> > > > > > > [    0.581289] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus
> > > > > > > number 3
> > > > > > > [    0.581304] ehci-pci 0000:00:1d.7: debug port 1
> > > > > > > [    0.585225] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfb5fe000
> > > > > > > [    0.601021] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> > > > > > > [    0.601099] usb usb3: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0002, bcdDevice= 6.11
> > > > > > > [    0.601103] usb usb3: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.601105] usb usb3: Product: EHCI Host Controller
> > > > > > > [    0.601107] usb usb3: Manufacturer: Linux 6.11.0 ehci_hcd
> > > > > > > [    0.601108] usb usb3: SerialNumber: 0000:00:1d.7
> > > > > > > [    0.601354] hub 3-0:1.0: USB hub found
> > > > > > > [    0.601366] hub 3-0:1.0: 6 ports detected
> > > > > > > [    0.601649] uhci_hcd 0000:00:1a.1: UHCI Host Controller
> > > > > > > [    0.601659] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus
> > > > > > > number 4
> > > > > > > [    0.601668] uhci_hcd 0000:00:1a.1: detected 2 ports
> > > > > > > [    0.601701] uhci_hcd 0000:00:1a.1: irq 21, io port 0x00009880
> > > > > > > [    0.601762] usb usb4: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0001, bcdDevice= 6.11
> > > > > > > [    0.601765] usb usb4: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.601767] usb usb4: Product: UHCI Host Controller
> > > > > > > [    0.601768] usb usb4: Manufacturer: Linux 6.11.0 uhci_hcd
> > > > > > > [    0.601770] usb usb4: SerialNumber: 0000:00:1a.1
> > > > > > > [    0.601959] hub 4-0:1.0: USB hub found
> > > > > > > [    0.601971] hub 4-0:1.0: 2 ports detected
> > > > > > > [    0.602279] uhci_hcd 0000:00:1a.2: UHCI Host Controller
> > > > > > > [    0.602285] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus
> > > > > > > number 5
> > > > > > > [    0.602292] uhci_hcd 0000:00:1a.2: detected 2 ports
> > > > > > > [    0.602319] uhci_hcd 0000:00:1a.2: irq 19, io port 0x00009c00
> > > > > > > [    0.602378] usb usb5: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0001, bcdDevice= 6.11
> > > > > > > [    0.602381] usb usb5: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.602383] usb usb5: Product: UHCI Host Controller
> > > > > > > [    0.602385] usb usb5: Manufacturer: Linux 6.11.0 uhci_hcd
> > > > > > > [    0.602387] usb usb5: SerialNumber: 0000:00:1a.2
> > > > > > > [    0.602571] hub 5-0:1.0: USB hub found
> > > > > > > [    0.602582] hub 5-0:1.0: 2 ports detected
> > > > > > > [    0.602821] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> > > > > > > [    0.602827] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus
> > > > > > > number 6
> > > > > > > [    0.602834] uhci_hcd 0000:00:1d.0: detected 2 ports
> > > > > > > [    0.602852] uhci_hcd 0000:00:1d.0: irq 23, io port 0x00009080
> > > > > > > [    0.602905] usb usb6: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0001, bcdDevice= 6.11
> > > > > > > [    0.602908] usb usb6: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.602910] usb usb6: Product: UHCI Host Controller
> > > > > > > [    0.602911] usb usb6: Manufacturer: Linux 6.11.0 uhci_hcd
> > > > > > > [    0.602913] usb usb6: SerialNumber: 0000:00:1d.0
> > > > > > > [    0.603096] hub 6-0:1.0: USB hub found
> > > > > > > [    0.603108] hub 6-0:1.0: 2 ports detected
> > > > > > > [    0.603355] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> > > > > > > [    0.603366] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus
> > > > > > > number 7
> > > > > > > [    0.603373] uhci_hcd 0000:00:1d.1: detected 2 ports
> > > > > > > [    0.603390] uhci_hcd 0000:00:1d.1: irq 19, io port 0x00009400
> > > > > > > [    0.603444] usb usb7: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0001, bcdDevice= 6.11
> > > > > > > [    0.603447] usb usb7: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.603449] usb usb7: Product: UHCI Host Controller
> > > > > > > [    0.603450] usb usb7: Manufacturer: Linux 6.11.0 uhci_hcd
> > > > > > > [    0.603452] usb usb7: SerialNumber: 0000:00:1d.1
> > > > > > > [    0.603636] hub 7-0:1.0: USB hub found
> > > > > > > [    0.603648] hub 7-0:1.0: 2 ports detected
> > > > > > > [    0.603900] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> > > > > > > [    0.603907] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus
> > > > > > > number 8
> > > > > > > [    0.603913] uhci_hcd 0000:00:1d.2: detected 2 ports
> > > > > > > [    0.603931] uhci_hcd 0000:00:1d.2: irq 18, io port 0x00009480
> > > > > > > [    0.603984] usb usb8: New USB device found, idVendor=1d6b,
> > > > > > > idProduct=0001, bcdDevice= 6.11
> > > > > > > [    0.603987] usb usb8: New USB device strings: Mfr=3, Product=2,
> > > > > > > SerialNumber=1
> > > > > > > [    0.603989] usb usb8: Product: UHCI Host Controller
> > > > > > > [    0.603991] usb usb8: Manufacturer: Linux 6.11.0 uhci_hcd
> > > > > > > [    0.603992] usb usb8: SerialNumber: 0000:00:1d.2
> > > > > > > [    0.604175] hub 8-0:1.0: USB hub found
> > > > > > > [    0.604187] hub 8-0:1.0: 2 ports detected
> > > > > > > [    0.604507] i8042: PNP: No PS/2 controller found.
> > > > > > > [    0.604509] i8042: Probing ports directly.
> > > > > > > [    0.607314] serio: i8042 KBD port at 0x60,0x64 irq 1
> > > > > > > [    0.607322] serio: i8042 AUX port at 0x60,0x64 irq 12
> > > > > > > [    0.607576] mousedev: PS/2 mouse device common for all mice
> > > > > > > [    0.607851] rtc_cmos 00:01: RTC can wake from S4
> > > > > > > [    0.608175] rtc_cmos 00:01: registered as rtc0
> > > > > > > [    0.608206] rtc_cmos 00:01: setting system clock to 2024-09-16T20:18:41
> > > > > > > UTC (1726517921)
> > > > > > > [    0.608248] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram,
> > > > > > > hpet irqs
> > > > > > > [    0.608269] i2c_dev: i2c /dev entries driver
> > > > > > > [    0.609016] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled.
> > > > > > > Duplicate IMA measurements will not be recorded in the IMA log.
> > > > > > > [    0.609054] device-mapper: uevent: version 1.0.3
> > > > > > > [    0.609150] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:
> > > > > > > dm-devel@lists.linux.dev
> > > > > > > [    0.609178] platform eisa.0: Probing EISA bus 0
> > > > > > > [    0.609181] platform eisa.0: EISA: Cannot allocate resource for mainboard
> > > > > > > [    0.609183] platform eisa.0: Cannot allocate resource for EISA slot 1
> > > > > > > [    0.609185] platform eisa.0: Cannot allocate resource for EISA slot 2
> > > > > > > [    0.609186] platform eisa.0: Cannot allocate resource for EISA slot 3
> > > > > > > [    0.609188] platform eisa.0: Cannot allocate resource for EISA slot 4
> > > > > > > [    0.609189] platform eisa.0: Cannot allocate resource for EISA slot 5
> > > > > > > [    0.609191] platform eisa.0: Cannot allocate resource for EISA slot 6
> > > > > > > [    0.609192] platform eisa.0: Cannot allocate resource for EISA slot 7
> > > > > > > [    0.609194] platform eisa.0: Cannot allocate resource for EISA slot 8
> > > > > > > [    0.609195] platform eisa.0: EISA: Detected 0 cards
> > > > > > > [    0.609198] intel_pstate: CPU model not supported
> > > > > > > [    0.609512] ledtrig-cpu: registered to indicate activity on CPUs
> > > > > > > [    0.609564] vesafb: mode is 1920x1080x32, linelength=7680, pages=0
> > > > > > > [    0.609566] vesafb: scrolling: redraw
> > > > > > > [    0.609567] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
> > > > > > > [    0.609588] vesafb: framebuffer at 0xd0000000, mapped to
> > > > > > > 0x(____ptrval____), using 8128k, total 8128k
> > > > > > > [    0.609716] fbcon: Deferring console take-over
> > > > > > > [    0.609720] fb0: VESA VGA frame buffer device
> > > > > > > [    0.609756] fujitsu_tablet: Unknown (using defaults)
> > > > > > > [    0.609870] drop_monitor: Initializing network drop monitor service
> > > > > > > [    0.610200] NET: Registered PF_INET6 protocol family
> > > > > > > [    0.809011] usb 2-5: new high-speed USB device number 2 using ehci-pci
> > > > > > > [    0.965402] usb 2-5: New USB device found, idVendor=0409, idProduct=005a,
> > > > > > > bcdDevice= 1.00
> > > > > > > [    0.965410] usb 2-5: New USB device strings: Mfr=0, Product=0,
> > > > > > > SerialNumber=0
> > > > > > > [    0.965833] hub 2-5:1.0: USB hub found
> > > > > > > [    0.966029] hub 2-5:1.0: 4 ports detected
> > > > > > > [    1.060999] usb 6-1: new full-speed USB device number 2 using uhci_hcd
> > > > > > > [    1.254086] usb 6-1: New USB device found, idVendor=1784, idProduct=0001,
> > > > > > > bcdDevice= 0.00
> > > > > > > [    1.254094] usb 6-1: New USB device strings: Mfr=1, Product=2,
> > > > > > > SerialNumber=3
> > > > > > > [    1.254096] usb 6-1: Product: eHome Infrared Transceiver
> > > > > > > [    1.254098] usb 6-1: Manufacturer: Topseed
> > > > > > > [    1.254100] usb 6-1: SerialNumber: TS000IUz
> > > > > > > [    1.256907] usb 2-5.1: new low-speed USB device number 3 using ehci-pci
> > > > > > > [    1.371648] usb 2-5.1: New USB device found, idVendor=046d,
> > > > > > > idProduct=c317, bcdDevice= 0.70
> > > > > > > [    1.371656] usb 2-5.1: New USB device strings: Mfr=1, Product=2,
> > > > > > > SerialNumber=0
> > > > > > > [    1.371658] usb 2-5.1: Product: USB Multimedia Keyboard
> > > > > > > [    1.371660] usb 2-5.1: Manufacturer: Logitech
> > > > > > > [    1.448914] usb 2-5.2: new high-speed USB device number 4 using ehci-pci
> > > > > > > [    1.525172] tsc: Refined TSC clocksource calibration: 2672.735 MHz
> > > > > > > [    1.525186] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
> > > > > > > 0x2686a22b34e, max_idle_ns: 440795332917 ns
> > > > > > > [    1.525285] clocksource: Switched to clocksource tsc
> > > > > > > [    1.558738] usb 2-5.2: New USB device found, idVendor=1532,
> > > > > > > idProduct=0e05, bcdDevice= 8.21
> > > > > > > [    1.558746] usb 2-5.2: New USB device strings: Mfr=1, Product=2,
> > > > > > > SerialNumber=0
> > > > > > > [    1.558748] usb 2-5.2: Product: Razer Kiyo Pro
> > > > > > > [    1.558750] usb 2-5.2: Manufacturer: Razer Inc
> > > > > > > [    1.636911] usb 2-5.4: new high-speed USB device number 5 using ehci-pci
> > > > > > > [    1.757135] usb 2-5.4: New USB device found, idVendor=0bda,
> > > > > > > idProduct=2838, bcdDevice= 1.00
> > > > > > > [    1.757143] usb 2-5.4: New USB device strings: Mfr=1, Product=2,
> > > > > > > SerialNumber=3
> > > > > > > [    1.757145] usb 2-5.4: Product: RTL2838UHIDIR
> > > > > > > [    1.757147] usb 2-5.4: Manufacturer: Realtek
> > > > > > > [    1.757148] usb 2-5.4: SerialNumber: 00000001
> > > > > > > [    1.896915] usb 7-1: new low-speed USB device number 2 using uhci_hcd
> > > > > > > [    2.090985] usb 7-1: New USB device found, idVendor=1c4f, idProduct=0034,
> > > > > > > bcdDevice= 1.10
> > > > > > > [    2.090993] usb 7-1: New USB device strings: Mfr=1, Product=2,
> > > > > > > SerialNumber=0
> > > > > > > [    2.090995] usb 7-1: Product: Usb Mouse
> > > > > > > [    2.090997] usb 7-1: Manufacturer: SIGMACHIP
> > > > > > > [    2.520914] usb 3-4: new high-speed USB device number 4 using ehci-pci
> > > > > > > [    2.695073] usb 3-4: New USB device found, idVendor=0b05, idProduct=1784,
> > > > > > > bcdDevice= 1.01
> > > > > > > [    2.695080] usb 3-4: New USB device strings: Mfr=1, Product=2,
> > > > > > > SerialNumber=3
> > > > > > > [    2.695083] usb 3-4: Product: 802.11 n WLAN
> > > > > > > [    2.695085] usb 3-4: Manufacturer: Ralink
> > > > > > > [    2.695086] usb 3-4: SerialNumber: 1.0
> > > > > > > [    6.983494] Freeing initrd memory: 732708K
> > > > > > > [    6.993078] Segment Routing with IPv6
> > > > > > > [    6.993112] In-situ OAM (IOAM) with IPv6
> > > > > > > [    6.993166] NET: Registered PF_PACKET protocol family
> > > > > > > [    6.993452] Key type dns_resolver registered
> > > > > > > [    6.994849] microcode: Current revision: 0x00000012
> > > > > > > [    6.994854] microcode: Updated early from: 0x00000010
> > > > > > > [    6.995662] IPI shorthand broadcast: enabled
> > > > > > > [    6.998021] sched_clock: Marking stable (6996004567,
> > > > > > > 824148)->(7068598070, -71769355)
> > > > > > > [    6.998330] registered taskstats version 1
> > > > > > > [    6.999038] Loading compiled-in X.509 certificates
> > > > > > > [    7.000201] Loaded X.509 cert 'Build time autogenerated kernel key:
> > > > > > > 8b9c4d5ea71199831d97e735201ace9ff8457a95'
> > > > > > > [    7.003218] Demotion targets for Node 0: null
> > > > > > > [    7.003551] Key type .fscrypt registered
> > > > > > > [    7.003556] Key type fscrypt-provisioning registered
> > > > > > > [    7.015077] cryptd: max_cpu_qlen set to 1000
> > > > > > > [    7.055597] Key type encrypted registered
> > > > > > > [    7.055608] AppArmor: AppArmor sha256 policy hashing enabled
> > > > > > > [    7.055626] ima: No TPM chip found, activating TPM-bypass!
> > > > > > > [    7.055639] Loading compiled-in module X.509 certificates
> > > > > > > [    7.056587] Loaded X.509 cert 'Build time autogenerated kernel key:
> > > > > > > 8b9c4d5ea71199831d97e735201ace9ff8457a95'
> > > > > > > [    7.056590] ima: Allocated hash algorithm: sha1
> > > > > > > [    7.056598] ima: No architecture policies found
> > > > > > > [    7.056614] evm: Initialising EVM extended attributes:
> > > > > > > [    7.056615] evm: security.selinux
> > > > > > > [    7.056616] evm: security.SMACK64
> > > > > > > [    7.056617] evm: security.SMACK64EXEC
> > > > > > > [    7.056618] evm: security.SMACK64TRANSMUTE
> > > > > > > [    7.056619] evm: security.SMACK64MMAP
> > > > > > > [    7.056620] evm: security.apparmor
> > > > > > > [    7.056621] evm: security.ima
> > > > > > > [    7.056622] evm: security.capability
> > > > > > > [    7.056623] evm: HMAC attrs: 0x1
> > > > > > > [    7.057049] PM:   Magic number: 8:614:346
> > > > > > > [    7.057098] tty tty63: hash matches
> > > > > > > [    7.061477] RAS: Correctable Errors collector initialized.
> > > > > > > [    7.061561] clk: Disabling unused clocks
> > > > > > > [    7.061564] PM: genpd: Disabling unused power domains
> > > > > > > [    7.066690] Freeing unused decrypted memory: 2036K
> > > > > > > [    7.067974] Freeing unused kernel image (initmem) memory: 4860K
> > > > > > > [    7.068170] Write protecting the kernel read-only data: 28672k
> > > > > > > [    7.068986] Freeing unused kernel image (rodata/data gap) memory: 864K
> > > > > > > [    7.160616] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> > > > > > > [    7.160704] x86/mm: Checking user space page tables
> > > > > > > [    7.221245] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> > > > > > > [    7.221251] Run /init as init process
> > > > > > > [    7.221253]   with arguments:
> > > > > > > [    7.221254]     /init
> > > > > > > [    7.221255]     splash
> > > > > > > [    7.221256]   with environment:
> > > > > > > [    7.221257]     HOME=/
> > > > > > > [    7.221258]     TERM=linux
> > > > > > > [    7.221259]     BOOT_IMAGE=/vmlinuz-6.11.0
> > > > > > > [    7.375505] ACPI Warning: SystemIO range
> > > > > > > 0x0000000000000828-0x000000000000082F conflicts with OpRegion
> > > > > > > 0x0000000000000800-0x000000000000084F (\PMRG) (20240322/utaddress-204)
> > > > > > > [    7.375517] ACPI: OSL: Resource conflict; ACPI support missing from
> > > > > > > driver?
> > > > > > > [    7.375522] ACPI Warning: SystemIO range
> > > > > > > 0x0000000000000530-0x000000000000053F conflicts with OpRegion
> > > > > > > 0x0000000000000500-0x000000000000053F (\GPS0) (20240322/utaddress-204)
> > > > > > > [    7.375529] ACPI: OSL: Resource conflict; ACPI support missing from
> > > > > > > driver?
> > > > > > > [    7.375531] ACPI Warning: SystemIO range
> > > > > > > 0x0000000000000500-0x000000000000052F conflicts with OpRegion
> > > > > > > 0x0000000000000500-0x000000000000053F (\GPS0) (20240322/utaddress-204)
> > > > > > > [    7.375537] ACPI: OSL: Resource conflict; ACPI support missing from
> > > > > > > driver?
> > > > > > > [    7.375538] lpc_ich: Resource conflict(s) found affecting gpio_ich
> > > > > > > [    7.384601] sky2: driver version 1.30
> > > > > > > [    7.384756] sky2 0000:08:00.0: Yukon-2 EC Ultra chip revision 3
> > > > > > > [    7.385087] sky2 0000:08:00.0 eth0: addr 00:23:54:9e:5b:d0
> > > > > > > [    7.385184] sky2 0000:06:00.0: Yukon-2 EC Ultra chip revision 3
> > > > > > > [    7.385497] sky2 0000:06:00.0 eth1: addr 00:23:54:9e:5b:cf
> > > > > > > [    7.390107] ahci 0000:00:1f.2: version 3.0
> > > > > > > [    7.391435] ACPI Warning: SystemIO range
> > > > > > > 0x0000000000000400-0x000000000000041F conflicts with OpRegion
> > > > > > > 0x0000000000000400-0x000000000000040F (\SMRG) (20240322/utaddress-204)
> > > > > > > [    7.391445] ACPI: OSL: Resource conflict; ACPI support missing from
> > > > > > > driver?
> > > > > > > [    7.392355] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
> > > > > > > [    7.392400] ahci 0000:00:1f.2: AHCI vers 0001.0200, 32 command slots, 3
> > > > > > > Gbps, SATA mode
> > > > > > > [    7.392405] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> > > > > > > [    7.392408] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp
> > > > > > > pio slum part ccc ems sxs
> > > > > > > [    7.397468] hid: raw HID events driver (C) Jiri Kosina
> > > > > > > [    7.438438] sky2 0000:08:00.0 enp8s0: renamed from eth0
> > > > > > > [    7.438941] sky2 0000:06:00.0 enp6s0: renamed from eth1
> > > > > > > [    7.446100] usbcore: registered new interface driver usbhid
> > > > > > > [    7.446103] usbhid: USB HID core driver
> > > > > > > [    7.449704] scsi host0: ahci
> > > > > > > [    7.450043] scsi host1: ahci
> > > > > > > [    7.450177] input: Logitech USB Multimedia Keyboard as /devices/pci0000:00/0000:00:1a.7/usb2/2-5/2-5.1/2-5.1:1.0/0003:046D:C317.0001/input/input5
> > > > > > > [    7.450206] scsi host2: ahci
> > > > > > > [    7.450384] scsi host3: ahci
> > > > > > > [    7.450534] scsi host4: ahci
> > > > > > > [    7.450680] scsi host5: ahci
> > > > > > > [    7.450765] ata1: SATA max UDMA/133 abar m2048@0xfb5fc000 port 0xfb5fc100
> > > > > > > irq 29 lpm-pol 0
> > > > > > > [    7.450769] ata2: SATA max UDMA/133 abar m2048@0xfb5fc000 port 0xfb5fc180
> > > > > > > irq 29 lpm-pol 0
> > > > > > > [    7.450772] ata3: SATA max UDMA/133 abar m2048@0xfb5fc000 port 0xfb5fc200
> > > > > > > irq 29 lpm-pol 0
> > > > > > > [    7.450775] ata4: SATA max UDMA/133 abar m2048@0xfb5fc000 port 0xfb5fc280
> > > > > > > irq 29 lpm-pol 0
> > > > > > > [    7.450778] ata5: SATA max UDMA/133 abar m2048@0xfb5fc000 port 0xfb5fc300
> > > > > > > irq 29 lpm-pol 0
> > > > > > > [    7.450781] ata6: SATA max UDMA/133 abar m2048@0xfb5fc000 port 0xfb5fc380
> > > > > > > irq 29 lpm-pol 0
> > > > > > > [    7.509365] hid-generic 0003:046D:C317.0001: input,hidraw0: USB HID v1.10
> > > > > > > Keyboard [Logitech USB Multimedia Keyboard] on usb-0000:00:1a.7-5.1/input0
> > > > > > > [    7.509615] input: Logitech USB Multimedia Keyboard System Control as /devices/pci0000:00/0000:00:1a.7/usb2/2-5/2-5.1/2-5.1:1.1/0003:046D:C317.0002/input/input6
> > > > > > > [    7.512965] firewire_ohci 0000:0b:02.0: added OHCI v1.10 device as card
> > > > > > > 0, 4 IR + 8 IT contexts, quirks 0x11
> > > > > > > [    7.525915] ACPI: bus type drm_connector registered
> > > > > > > [    7.569198] input: Logitech USB Multimedia Keyboard Consumer Control as /devices/pci0000:00/0000:00:1a.7/usb2/2-5/2-5.1/2-5.1:1.1/0003:046D:C317.0002/input/input7
> > > > > > > [    7.569501] hid-generic 0003:046D:C317.0002: input,hidraw1: USB HID v1.10
> > > > > > > Device [Logitech USB Multimedia Keyboard] on usb-0000:00:1a.7-5.1/input1
> > > > > > > [    7.569707] input: SIGMACHIP Usb Mouse as /devices/pci0000:00/0000:00:1d.1/usb7/7-1/7-1:1.0/0003:1C4F:0034.0003/input/input8
> > > > > > > [    7.570110] hid-generic 0003:1C4F:0034.0003: input,hidraw2: USB HID v1.10
> > > > > > > Mouse [SIGMACHIP Usb Mouse] on usb-0000:00:1d.1-1/input0
> > > > > > > [    7.924893] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > > > > > > [    7.925710] ata1.00: ATA-10: WD Blue SA510 2.5 2TB, 530309WD, max
> > > > > > > UDMA/133
> > > > > > > [    7.925801] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),
> > > > > > > AA
> > > > > > > [    7.926415] ata1.00: Features: Dev-Sleep
> > > > > > > [    7.927326] ata1.00: configured for UDMA/133
> > > > > > > [    7.927586] scsi 0:0:0:0: Direct-Access     ATA      WD Blue SA510 2.
> > > > > > > 09WD PQ: 0 ANSI: 5
> > > > > > > [    7.928008] scsi 0:0:0:0: Attached scsi generic sg0 type 0
> > > > > > > [    8.025099] firewire_core 0000:0b:02.0: created device fw0: GUID
> > > > > > > 001e8c0001b0584a, S400
> > > > > > > [    8.404993] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > > > > > > [    8.416099] ata2.00: ATA-8: Corsair Force 3 SSD, 1.3.2, max UDMA/133
> > > > > > > [    8.416606] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 32),
> > > > > > > AA
> > > > > > > [    8.426528] ata2.00: configured for UDMA/133
> > > > > > > [    8.426791] scsi 1:0:0:0: Direct-Access     ATA      Corsair Force 3
> > > > > > > 2    PQ: 0 ANSI: 5
> > > > > > > [    8.427456] scsi 1:0:0:0: Attached scsi generic sg1 type 0
> > > > > > > [    8.904925] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > > > > > > [    8.905740] ata3.00: ATA-10: WD Blue SA510 2.5 2TB, 530309WD, max
> > > > > > > UDMA/133
> > > > > > > [    8.905838] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),
> > > > > > > AA
> > > > > > > [    8.906448] ata3.00: Features: Dev-Sleep
> > > > > > > [    8.907336] ata3.00: configured for UDMA/133
> > > > > > > [    8.907542] scsi 2:0:0:0: Direct-Access     ATA      WD Blue SA510 2.
> > > > > > > 09WD PQ: 0 ANSI: 5
> > > > > > > [    8.908069] scsi 2:0:0:0: Attached scsi generic sg2 type 0
> > > > > > > [    9.392962] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > > > > > > [    9.394169] ata4.00: ATA-8: ST3500418AS, CC38, max UDMA/133
> > > > > > > [    9.394176] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32)
> > > > > > > [    9.395560] ata4.00: configured for UDMA/133
> > > > > > > [    9.395767] scsi 3:0:0:0: Direct-Access     ATA ST3500418AS      CC38 PQ:
> > > > > > > 0 ANSI: 5
> > > > > > > [    9.396339] scsi 3:0:0:0: Attached scsi generic sg3 type 0
> > > > > > > [    9.876891] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > > > > > > [    9.877133] ata5.00: ATA-10: KINGSTON SA400S37480G, SBFKK1B3, max
> > > > > > > UDMA/133
> > > > > > > [    9.877216] ata5.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 32), AA
> > > > > > > [    9.877559] ata5.00: configured for UDMA/133
> > > > > > > [    9.877838] scsi 4:0:0:0: Direct-Access     ATA      KINGSTON SA400S3
> > > > > > > K1B3 PQ: 0 ANSI: 5
> > > > > > > [    9.878294] scsi 4:0:0:0: Attached scsi generic sg4 type 0
> > > > > > > [   10.352870] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > > > > > > [   10.354014] ata6.00: ATAPI: DRW-24F1ST   d, 2.00, max UDMA/133
> > > > > > > [   10.355420] ata6.00: configured for UDMA/133
> > > > > > > [   10.358873] scsi 5:0:0:0: CD-ROM            ASUS DRW-24F1ST   d   2.00
> > > > > > > PQ: 0 ANSI: 5
> > > > > > > [   10.463913] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/12x writer dvd-ram
> > > > > > > cd/rw xa/form2 cdda tray
> > > > > > > [   10.463919] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > > > > > [   10.501960] sr 5:0:0:0: Attached scsi CD-ROM sr0
> > > > > > > [   10.502081] sr 5:0:0:0: Attached scsi generic sg5 type 5
> > > > > > > [   10.507297] scsi host6: pata_marvell
> > > > > > > [   10.507511] scsi host7: pata_marvell
> > > > > > > [   10.507593] ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 0xc400
> > > > > > > irq 16 lpm-pol 0
> > > > > > > [   10.507596] ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc408
> > > > > > > irq 16 lpm-pol 0
> > > > > > > [   10.514525] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00
> > > > > > > TB/1.82 TiB)
> > > > > > > [   10.514542] sd 0:0:0:0: [sda] Write Protect is off
> > > > > > > [   10.514546] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > > > > > > [   10.514567] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
> > > > > > > doesn't support DPO or FUA
> > > > > > > [   10.514570] sd 1:0:0:0: [sdb] 234441648 512-byte logical blocks: (120
> > > > > > > GB/112 GiB)
> > > > > > > [   10.514587] sd 1:0:0:0: [sdb] Write Protect is off
> > > > > > > [   10.514591] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> > > > > > > [   10.514610] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> > > > > > > [   10.514610] sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00
> > > > > > > TB/1.82 TiB)
> > > > > > > [   10.514618] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
> > > > > > > doesn't support DPO or FUA
> > > > > > > [   10.514622] sd 3:0:0:0: [sdd] 976773168 512-byte logical blocks: (500
> > > > > > > GB/466 GiB)
> > > > > > > [   10.514623] sd 2:0:0:0: [sdc] Write Protect is off
> > > > > > > [   10.514627] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> > > > > > > [   10.514639] sd 3:0:0:0: [sdd] Write Protect is off
> > > > > > > [   10.514643] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> > > > > > > [   10.514649] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled,
> > > > > > > doesn't support DPO or FUA
> > > > > > > [   10.514650] sd 4:0:0:0: [sde] 937703088 512-byte logical blocks: (480
> > > > > > > GB/447 GiB)
> > > > > > > [   10.514659] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
> > > > > > > [   10.514672] sd 4:0:0:0: [sde] Write Protect is off
> > > > > > > [   10.514673] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled,
> > > > > > > doesn't support DPO or FUA
> > > > > > > [   10.514677] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
> > > > > > > [   10.514690] sd 2:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
> > > > > > > [   10.514706] sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled,
> > > > > > > doesn't support DPO or FUA
> > > > > > > [   10.514726] sd 3:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
> > > > > > > [   10.514747] sd 4:0:0:0: [sde] Preferred minimum I/O size 512 bytes
> > > > > > > [   10.557486]  sde: sde1
> > > > > > > [   10.557579] sd 4:0:0:0: [sde] Attached SCSI disk
> > > > > > > [   10.557928]  sda: sda1
> > > > > > > [   10.557999] sd 0:0:0:0: [sda] Attached SCSI disk
> > > > > > > [   10.558245] sd 2:0:0:0: [sdc] Attached SCSI disk
> > > > > > > [   10.560449]  sdb: sdb1 sdb2 sdb3
> > > > > > > [   10.560883] sd 1:0:0:0: [sdb] Attached SCSI disk
> > > > > > > [   10.602620]  sdd: sdd1
> > > > > > > [   10.602860] sd 3:0:0:0: [sdd] Attached SCSI disk
> > > > > > > [   18.784958] random: crng init done
> > > > > > > [   24.072890] raid6: sse2x4   gen()  9257 MB/s
> > > > > > > [   24.140893] raid6: sse2x2   gen() 11781 MB/s
> > > > > > > [   24.208892] raid6: sse2x1   gen()  9633 MB/s
> > > > > > > [   24.208894] raid6: using algorithm sse2x2 gen() 11781 MB/s
> > > > > > > [   24.276889] raid6: .... xor() 7155 MB/s, rmw enabled
> > > > > > > [   24.276891] raid6: using ssse3x2 recovery algorithm
> > > > > > > [   24.279508] xor: measuring software checksum speed
> > > > > > > [   24.280148]    prefetch64-sse  : 15495 MB/sec
> > > > > > > [   24.280906]    generic_sse     : 13259 MB/sec
> > > > > > > [   24.280908] xor: using function: prefetch64-sse (15495 MB/sec)
> > > > > > > [   24.283562] async_tx: api initialized (async)
> > > > > > > [   24.888184] Btrfs loaded, zoned=yes, fsverity=yes
> > > > > > > [   25.121189] EXT4-fs (sde1): mounted filesystem
> > > > > > > 94072726-5fed-439f-a496-8e6aaa88617e ro with ordered data mode. Quota mode:
> > > > > > > none.
> > > > > > > [   25.650104] systemd[1]: Inserted module 'autofs4'
> > > > > > > [   25.720961] systemd[1]: systemd 249.11-0ubuntu3.12 running in system mode
> > > > > > > (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS
> > > > > > > +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD
> > > > > > > +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ
> > > > > > > +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> > > > > > > [   25.721115] systemd[1]: Detected architecture x86-64.
> > > > > > > [   26.209831] systemd[1]: Configuration file
> > > > > > > /run/systemd/system/netplan-ovs-cleanup.service is marked
> > > > > > > world-inaccessible. This has no effect as configuration data is accessible
> > > > > > > via APIs without restrictions. Proceeding anyway.
> > > > > > > [   26.282129] systemd[1]: Accepting user/group name '${GNUNET_USER}', which
> > > > > > > does not match strict user/group name rules.
> > > > > > > [   26.341173] systemd[1]: Queued start job for default target Graphical
> > > > > > > Interface.
> > > > > > > [   26.382658] systemd[1]: Created slice Slice /system/modprobe.
> > > > > > > [   26.383229] systemd[1]: Created slice Slice /system/systemd-fsck.
> > > > > > > [   26.383636] systemd[1]: Created slice User and Session Slice.
> > > > > > > [   26.383727] systemd[1]: Started Forward Password Requests to Wall
> > > > > > > Directory Watch.
> > > > > > > [   26.383934] systemd[1]: Set up automount Arbitrary Executable File
> > > > > > > Formats File System Automount Point.
> > > > > > > [   26.384053] systemd[1]: Reached target User and Group Name Lookups.
> > > > > > > [   26.384087] systemd[1]: Reached target Slice Units.
> > > > > > > [   26.384122] systemd[1]: Reached target Local Verity Protected Volumes.
> > > > > > > [   26.384233] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> > > > > > > [   26.384385] systemd[1]: Listening on LVM2 poll daemon socket.
> > > > > > > [   26.390357] systemd[1]: Listening on RPCbind Server Activation Socket.
> > > > > > > [   26.390560] systemd[1]: Listening on Syslog Socket.
> > > > > > > [   26.392228] systemd[1]: Listening on Process Core Dump Socket.
> > > > > > > [   26.392358] systemd[1]: Listening on fsck to fsckd communication Socket.
> > > > > > > [   26.392444] systemd[1]: Listening on initctl Compatibility Named Pipe.
> > > > > > > [   26.392728] systemd[1]: Listening on Journal Audit Socket.
> > > > > > > [   26.392878] systemd[1]: Listening on Journal Socket (/dev/log).
> > > > > > > [   26.393048] systemd[1]: Listening on Journal Socket.
> > > > > > > [   26.393622] systemd[1]: Listening on udev Control Socket.
> > > > > > > [   26.393770] systemd[1]: Listening on udev Kernel Socket.
> > > > > > > [   26.394928] systemd[1]: Mounting Huge Pages File System...
> > > > > > > [   26.396045] systemd[1]: Mounting POSIX Message Queue File System...
> > > > > > > [   26.397206] systemd[1]: Mounting Kernel Debug File System...
> > > > > > > [   26.398341] systemd[1]: Mounting Kernel Trace File System...
> > > > > > > [   26.400711] systemd[1]: Starting Journal Service...
> > > > > > > [   26.400852] systemd[1]: Condition check resulted in Kernel Module
> > > > > > > supporting RPCSEC_GSS being skipped.
> > > > > > > [   26.400981] systemd[1]: Finished Availability of block devices.
> > > > > > > [   26.402714] systemd[1]: Starting Set the console keyboard layout...
> > > > > > > [   26.403977] systemd[1]: Starting Create List of Static Device Nodes...
> > > > > > > [   26.405164] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots
> > > > > > > etc. using dmeventd or progress polling...
> > > > > > > [   26.406446] systemd[1]: Starting Load Kernel Module configfs...
> > > > > > > [   26.408022] systemd[1]: Starting Load Kernel Module drm...
> > > > > > > [   26.409876] systemd[1]: Starting Load Kernel Module efi_pstore...
> > > > > > > [   26.411397] systemd[1]: Starting Load Kernel Module fuse...
> > > > > > > [   26.411770] systemd[1]: Condition check resulted in File System Check on
> > > > > > > Root Device being skipped.
> > > > > > > [   26.419152] systemd[1]: Starting Load Kernel Modules...
> > > > > > > [   26.420372] systemd[1]: Starting Remount Root and Kernel File Systems...
> > > > > > > [   26.421670] systemd[1]: Starting Coldplug All udev Devices...
> > > > > > > [   26.424102] systemd[1]: Mounted Huge Pages File System.
> > > > > > > [   26.424285] systemd[1]: Mounted POSIX Message Queue File System.
> > > > > > > [   26.424439] systemd[1]: Mounted Kernel Debug File System.
> > > > > > > [   26.424592] systemd[1]: Mounted Kernel Trace File System.
> > > > > > > [   26.425138] systemd[1]: Finished Create List of Static Device Nodes.
> > > > > > > [   26.425552] systemd[1]:modprobe@configfs.service: Deactivated
> > > > > > > successfully.
> > > > > > > [   26.425869] systemd[1]: Finished Load Kernel Module configfs.
> > > > > > > [   26.426221] systemd[1]:modprobe@drm.service: Deactivated successfully.
> > > > > > > [   26.426531] systemd[1]: Finished Load Kernel Module drm.
> > > > > > > [   26.426889] systemd[1]:modprobe@fuse.service: Deactivated successfully.
> > > > > > > [   26.427195] systemd[1]: Finished Load Kernel Module fuse.
> > > > > > > [   26.428523] systemd[1]: Mounting FUSE Control File System...
> > > > > > > [   26.429778] systemd[1]: Mounting Kernel Configuration File System...
> > > > > > > [   26.431223] systemd[1]: Mounted FUSE Control File System.
> > > > > > > [   26.432057] systemd[1]: Mounted Kernel Configuration File System.
> > > > > > > [   26.448406] systemd[1]:modprobe@efi_pstore.service: Deactivated
> > > > > > > successfully.
> > > > > > > [   26.448945] systemd[1]: Finished Load Kernel Module efi_pstore.
> > > > > > > [   26.469212] EXT4-fs (sde1): re-mounted
> > > > > > > 94072726-5fed-439f-a496-8e6aaa88617e r/w. Quota mode: none.
> > > > > > > [   26.471407] systemd[1]: Finished Remount Root and Kernel File Systems.
> > > > > > > [   26.471675] systemd[1]: Condition check resulted in Platform Persistent
> > > > > > > Storage Archival being skipped.
> > > > > > > [   26.473420] systemd[1]: Starting Load/Save Random Seed...
> > > > > > > [   26.475161] systemd[1]: Starting Create System Users...
> > > > > > > [   26.483026] lp: driver loaded but no devices found
> > > > > > > [   26.493865] ppdev: user-space parallel port driver
> > > > > > > [   26.502393] systemd[1]: Finished Load/Save Random Seed.
> > > > > > > [   26.502655] systemd[1]: Condition check resulted in First Boot Complete
> > > > > > > being skipped.
> > > > > > > [   26.506712] systemd[1]: Finished Set the console keyboard layout.
> > > > > > > [   26.508747] systemd[1]: Finished Create System Users.
> > > > > > > [   26.510321] systemd[1]: Starting Create Static Device Nodes in /dev...
> > > > > > > [   26.511046] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots
> > > > > > > etc. using dmeventd or progress polling.
> > > > > > > [   26.528026] systemd[1]: Finished Load Kernel Modules.
> > > > > > > [   26.529531] systemd[1]: Starting Apply Kernel Variables...
> > > > > > > [   26.530139] systemd[1]: Finished Create Static Device Nodes in /dev.
> > > > > > > [   26.530349] systemd[1]: Reached target Preparation for Local File
> > > > > > > Systems.
> > > > > > > [   26.532348] systemd[1]: Starting Rule-based Manager for Device Events and
> > > > > > > Files...
> > > > > > > [   26.553864] systemd[1]: Started Journal Service.
> > > > > > > [   26.562848] systemd-journald[406]: Received client request to flush
> > > > > > > runtime journal.
> > > > > > > [   26.919447] i5500_temp 0000:00:14.3: Sensor seems to be disabled
> > > > > > > [   26.941867] EDAC MC0: Giving out device to module i7core_edac.c
> > > > > > > controller i7 core #0: DEV 0000:ff:03.0 (INTERRUPT)
> > > > > > > [   26.941914] EDAC PCI0: Giving out device to module i7core_edac controller
> > > > > > > EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
> > > > > > > [   26.941936] EDAC i7core: Driver loaded, 1 memory controller(s) found.
> > > > > > > [   27.501967] mc: Linux media interface: v0.10
> > > > > > > [   27.821741] videodev: Linux video capture interface: v2.00
> > > > > > > [   27.829839] kvm_intel: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work
> > > > > > > properly. Using workaround
> > > > > > > [   27.910536] snd_hda_intel 0000:04:00.1: Force to non-snoop mode
> > > > > > > [   27.927314] EXT4-fs (sdd1): mounted filesystem
> > > > > > > 269c3cb0-82a8-484f-9f96-2569d52ced08 r/w with ordered data mode. Quota mode:
> > > > > > > none.
> > > > > > > [   27.967879] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/0000:02:00.0/0000:03:00.0/0000:04:00.1/sound/card1/input9
> > > > > > > [   27.967995] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/0000:02:00.0/0000:03:00.0/0000:04:00.1/sound/card1/input10
> > > > > > > [   28.099282] EXT4-fs (sdb3): mounted filesystem
> > > > > > > 965f3d65-ec1b-49a8-a27a-a6989cecf661 r/w with ordered data mode. Quota mode:
> > > > > > > none.
> > > > > > > [   28.119031] EXT4-fs (sdc): mounted filesystem
> > > > > > > 7f49ad40-e533-42c4-9977-7c4809d47b3d r/w with ordered data mode. Quota mode:
> > > > > > > none.
> > > > > > > [   28.120177] EXT4-fs (sda1): mounted filesystem
> > > > > > > a7d8e4b2-e2df-4976-b661-37e48f7411cf r/w with ordered data mode. Quota mode:
> > > > > > > none.
> > > > > > > [   28.148845] Registered IR keymap rc-rc6-mce
> > > > > > > [   28.152056] Adding 15625212k swap on /dev/sdb2.  Priority:-2 extents:1
> > > > > > > across:15625212k SS
> > > > > > > [   28.169493] usb 2-5.2: Found UVC 1.00 device Razer Kiyo Pro (1532:0e05)
> > > > > > > [   28.174756] usbcore: registered new interface driver uvcvideo
> > > > > > > [   28.238001] IR RC6 protocol handler initialized
> > > > > > > [   28.301533] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 48000
> > > > > > > [   28.313037] rc rc0: Media Center Ed. eHome Infrared Remote Transceiver as
> > > > > > > /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/rc/rc0
> > > > > > > [   28.313134] rc rc0: lirc_dev: driver mceusb registered at minor = 0, raw
> > > > > > > IR receiver, raw IR transmitter
> > > > > > > [   28.313280] input: Media Center Ed. eHome Infrared Remote Transceiver as
> > > > > > > /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/rc/rc0/input11
> > > > > > > [   28.405085] snd_hda_codec_analog hdaudioC0D0: autoconfig for AD1989B:
> > > > > > > line_outs=4 (0x12/0x16/0x24/0x25/0x0) type:line
> > > > > > > [   28.405093] snd_hda_codec_analog hdaudioC0D0:    speaker_outs=0
> > > > > > > (0x0/0x0/0x0/0x0/0x0)
> > > > > > > [   28.405095] snd_hda_codec_analog hdaudioC0D0:    hp_outs=1
> > > > > > > (0x11/0x0/0x0/0x0/0x0)
> > > > > > > [   28.405098] snd_hda_codec_analog hdaudioC0D0:    mono: mono_out=0x0
> > > > > > > [   28.405099] snd_hda_codec_analog hdaudioC0D0: dig-out=0x1b/0x1d
> > > > > > > [   28.405101] snd_hda_codec_analog hdaudioC0D0:    inputs:
> > > > > > > [   28.405103] snd_hda_codec_analog hdaudioC0D0:      Rear Mic=0x17
> > > > > > > [   28.405105] snd_hda_codec_analog hdaudioC0D0:      Front Mic=0x14
> > > > > > > [   28.405106] snd_hda_codec_analog hdaudioC0D0:      Line=0x15
> > > > > > > [   28.405108] snd_hda_codec_analog hdaudioC0D0:      CD=0x18
> > > > > > > [   28.420231] input: HDA Intel Rear Mic as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
> > > > > > > [   28.420363] input: HDA Intel Front Mic as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
> > > > > > > [   28.420495] input: HDA Intel Line as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
> > > > > > > [   28.420592] input: HDA Intel Line Out Front as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
> > > > > > > [   28.420710] input: HDA Intel Line Out Surround as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
> > > > > > > [   28.420798] input: HDA Intel Line Out CLFE as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
> > > > > > > [   28.420905] input: HDA Intel Line Out Side as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
> > > > > > > [   28.421001] input: HDA Intel Front Headphone as
> > > > > > > /devices/pci0000:00/0000:00:1b.0/sound/card0/input19
> > > > > > > [   28.540353] cfg80211: Loading compiled-in X.509 certificates for
> > > > > > > regulatory database
> > > > > > > [   28.540722] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > > > > > > [   28.541013] Loaded X.509 cert 'wens:
> > > > > > > 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> > > > > > > [   28.541974] mceusb 6-1:1.0: long-range (0x1) receiver active
> > > > > > > [   28.571526] cx23885: cx23885 driver version 0.0.4 loaded
> > > > > > > [   28.571754] cx23885: CORE cx23885[0]: subsystem: 0070:7801, board:
> > > > > > > Hauppauge WinTV-HVR1800 [card=2,autodetected]
> > > > > > > [   28.605043] mceusb 6-1:1.0: Registered Topseed eHome Infrared Transceiver
> > > > > > > with mce emulator interface version 1
> > > > > > > [   28.605052] mceusb 6-1:1.0: 2 tx ports (0x3 cabled) and 2 rx sensors (0x1
> > > > > > > active)
> > > > > > > [   28.605120] usbcore: registered new interface driver mceusb
> > > > > > > [   28.607375] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 24000
> > > > > > > [   28.613794] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 32000
> > > > > > > [   28.718690] usbcore: registered new interface driver snd-usb-audio
> > > > > > > [   29.013320] tveeprom: Hauppauge model 78521, rev C1E9, serial# 4029759297
> > > > > > > [   29.013327] tveeprom: MAC address is 00:0d:fe:31:3f:41
> > > > > > > [   29.013329] tveeprom: tuner model is Philips 18271_8295 (idx 149, type
> > > > > > > 54)
> > > > > > > [   29.013331] tveeprom: TV standards NTSC(M) ATSC/DVB Digital (eeprom 0x88)
> > > > > > > [   29.013333] tveeprom: audio processor is CX23887 (idx 42)
> > > > > > > [   29.013334] tveeprom: decoder processor is CX23887 (idx 37)
> > > > > > > [   29.013335] tveeprom: has radio
> > > > > > > [   29.013336] cx23885: cx23885[0]: hauppauge eeprom: model=78521
> > > > > > > [   29.101189] cx25840 2-0044: cx23887 A/V decoder found @ 0x88 (cx23885[0])
> > > > > > > [   29.560967] usb 3-4: reset high-speed USB device number 4 using ehci-pci
> > > > > > > [   29.731550] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3071, rev
> > > > > > > 021c detected
> > > > > > > [   29.760952] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0008
> > > > > > > detected
> > > > > > > [   29.761293] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> > > > > > > [   29.761939] usbcore: registered new interface driver rt2800usb
> > > > > > > [   29.792083] rt2800usb 3-4:1.0 wlx20cf30a24130: renamed from wlan0
> > > > > > > [   29.793914] cx25840 2-0044: loaded v4l-cx23885-avcore-01.fw firmware
> > > > > > > (16382 bytes)
> > > > > > > [   29.931887] tuner: 1-0042: Tuner -1 found with type(s) Radio TV.
> > > > > > > [   29.977929] tda829x 1-0042: could not clearly identify tuner address,
> > > > > > > defaulting to 60
> > > > > > > [   30.005283] tda18271 1-0060: creating new instance
> > > > > > > [   30.049326] tda18271: TDA18271HD/C1 detected @ 1-0060
> > > > > > > [   30.873273] tda829x 1-0042: type set to tda8295+18271
> > > > > > > [   32.228176] cx23885: cx23885[0]: registered device video2 [v4l2]
> > > > > > > [   32.228328] cx23885: cx23885[0]: registered device vbi0
> > > > > > > [   32.228612] cx23885: cx23885[0]: alsa: registered ALSA audio device
> > > > > > > [   32.228777] cx23885: cx23885[0]: registered device video3 [mpeg]
> > > > > > > [   32.228793] cx23885: Firmware and/or mailbox pointer not initialized or
> > > > > > > corrupted, signature = 0xffffbfff, cmd = PING_FW
> > > > > > > [   32.228801] fbcon: Taking over console
> > > > > > > [   32.229089] Console: switching to colour frame buffer device 240x67
> > > > > > > [   32.230049] cx23885 0000:09:00.0: Direct firmware load for
> > > > > > > v4l-cx23885-enc.fw failed with error -2
> > > > > > > [   32.230055] cx23885: ERROR: Hotplug firmware request failed
> > > > > > > (v4l-cx23885-enc.fw).
> > > > > > > [   32.230056] cx23885: Please fix your hotplug setup, the board will not
> > > > > > > work without firmware loaded!
> > > > > > > [   32.230057] cx23885: cx23885_initialize_codec() f/w load failed
> > > > > > > [   32.230059] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
> > > > > > > [   32.230061] cx23885: cx23885[0]: cx23885 based dvb card
> > > > > > > [   32.398080] MT2131: successfully identified at address 0x61
> > > > > > > [   32.399714] dvbdev: DVB: registering new adapter (cx23885[0])
> > > > > > > [   32.399718] cx23885 0000:09:00.0: DVB: registering adapter 0 frontend 0
> > > > > > > (Samsung S5H1409 QAM/8VSB Frontend)...
> > > > > > > [   32.400463] cx23885: cx23885_dev_checkrevision() Hardware revision = 0xb1
> > > > > > > [   32.400467] cx23885: cx23885[0]/0: found at 0000:09:00.0, rev: 15, irq:
> > > > > > > 17, latency: 0, mmio: 0xfbc00000
> > > > > > > [   43.045128] audit: type=1400 audit(1726517963.933:2): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="/usr/bin/lxc-start"
> > > > > > > pid=1473 comm="apparmor_parser"
> > > > > > > [   43.047845] audit: type=1400 audit(1726517963.933:3): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="nvidia_modprobe"
> > > > > > > pid=1470 comm="apparmor_parser"
> > > > > > > [   43.047854] audit: type=1400 audit(1726517963.933:4): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod"
> > > > > > > pid=1470 comm="apparmor_parser"
> > > > > > > [   43.047859] audit: type=1400 audit(1726517963.933:5): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="lsb_release" pid=1468
> > > > > > > comm="apparmor_parser"
> > > > > > > [   43.048576] audit: type=1400 audit(1726517963.933:6): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1474
> > > > > > > comm="apparmor_parser"
> > > > > > > [   43.048583] audit: type=1400 audit(1726517963.933:7): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="man_filter" pid=1474
> > > > > > > comm="apparmor_parser"
> > > > > > > [   43.048587] audit: type=1400 audit(1726517963.933:8): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="man_groff" pid=1474
> > > > > > > comm="apparmor_parser"
> > > > > > > [   43.053897] audit: type=1400 audit(1726517963.941:9): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="/usr/bin/redshift"
> > > > > > > pid=1476 comm="apparmor_parser"
> > > > > > > [   43.054106] audit: type=1400 audit(1726517963.941:10): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="libreoffice-oosplash"
> > > > > > > pid=1478 comm="apparmor_parser"
> > > > > > > [   43.054837] audit: type=1400 audit(1726517963.941:11): apparmor="STATUS"
> > > > > > > operation="profile_load" profile="unconfined" name="libreoffice-senddoc"
> > > > > > > pid=1479 comm="apparmor_parser"
> > > > > > > [   43.276873] RPC: Registered named UNIX socket transport module.
> > > > > > > [   43.276877] RPC: Registered udp transport module.
> > > > > > > [   43.276879] RPC: Registered tcp transport module.
> > > > > > > [   43.276879] RPC: Registered tcp-with-tls transport module.
> > > > > > > [   43.276880] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > > > > > > [   43.770189] sky2 0000:06:00.0 enp6s0: enabling interface
> > > > > > > [   43.781961] sky2 0000:08:00.0 enp8s0: enabling interface
> > > > > > > [   43.787810] ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading
> > > > > > > firmware file 'rt2870.bin'
> > > > > > > [   43.793640] ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware
> > > > > > > detected - version: 0.36
> > > > > > > [   45.854962] wlx20cf30a24130: authenticate with fc:2b:b2:a7:af:02 (local
> > > > > > > address=20:cf:30:a2:41:30)
> > > > > > > [   45.854969] wlx20cf30a24130: send auth to fc:2b:b2:a7:af:02 (try 1/3)
> > > > > > > [   45.867365] wlx20cf30a24130: authenticated
> > > > > > > [   45.868985] wlx20cf30a24130: associate with fc:2b:b2:a7:af:02 (try 1/3)
> > > > > > > [   45.877038] wlx20cf30a24130: RX AssocResp from fc:2b:b2:a7:af:02
> > > > > > > (capab=0x1411 status=0 aid=3)
> > > > > > > [   45.887555] wlx20cf30a24130: associated
> > > > > > > [   46.441910] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 48000
> > > > > > > [   46.558022] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 48000
> > > > > > > [   46.677063] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 48000
> > > > > > > [   46.695942] sky2 0000:06:00.0 enp6s0: Link is up at 1000 Mbps, full
> > > > > > > duplex, flow control both
> > > > > > > [   47.319604] wlx20cf30a24130: Limiting TX power to 30 (30 - 0) dBm as
> > > > > > > advertised by fc:2b:b2:a7:af:02
> > > > > > > [   59.697229] kauditd_printk_skb: 25 callbacks suppressed
> > > > > > > [   59.697233] audit: type=1400 audit(1726517980.585:37): apparmor="DENIED"
> > > > > > > operation="open" class="file" profile="/usr/sbin/cups-browsed"
> > > > > > > name="/usr/local/lib/libz.so.1.3" pid=2031 comm="cups-browsed"
> > > > > > > requested_mask="r" denied_mask="r" fsuid=0 ouid=0
> > > > > > > [   59.699869] audit: type=1400 audit(1726517980.585:38): apparmor="DENIED"
> > > > > > > operation="open" class="file" profile="/usr/sbin/cups-browsed"
> > > > > > > name="/usr/local/lib/libpng16.so.16.44.0" pid=2031 comm="cups-browsed"
> > > > > > > requested_mask="r" denied_mask="r" fsuid=0 ouid=0
> > > > > > > [   59.810741] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 48000
> > > > > > > [   59.921457] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 48000
> > > > > > > [   60.036414] usb 2-5.2: current rate 16000 is different from the runtime
> > > > > > > rate 48000
> > > > > > > [   63.727107] warning: `kdeconnectd' uses wireless extensions which will
> > > > > > > stop working for Wi-Fi 7 hardware; use nl80211
> > > > > > > 
> > > > > > > On 2024-09-16 11:20, Dr. David Alan Gilbert wrote:
> > > > > > > > * Bob Gill (gillb5@telus.net) wrote:
> > > > > > > > > OK.
> > > > > > > > Thanks!  I'm not seeing anything too obvious, however...
> > > > > > > > 
> > > > > > > > >      6.10.0.dmesg.txt:
> > > > > > > > > 
> > > > > > > > > [    0.000000] Linux version 6.10.0 (root@freedom) (gcc (Ubuntu
> > > > > > > > > 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP
> > > > > > > > > PREEMPT_DYNAMIC Sun Jul 14 18:50:17 MDT 2024
> > > > > > > > > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.10.0
> > > > > > > > > root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro quiet splash
> > > > > > > > .....
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 6.11.0.dmesg.txt
> > > > > > > > > 
> > > > > > > > > [    0.000000] Linux version 6.11.0 (root@freedom) (gcc (Ubuntu
> > > > > > > > > 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP
> > > > > > > > > PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024
> > > > > > > > > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.11.0
> > > > > > > > > root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro recovery nomodeset
> > > > > > > > > dis_ucode_ldr
> > > > > > > > > [    0.000000] KERNEL supported cpus:
> > > > > > > > Would it be possible to get a 6.11.0 dmesg without the 'nomodeset' ?
> > > > > > > > I realise that's trickier, but it's really where things start to get interesting.
> > > > > > > > 
> > > > > > > > On the 6.10 dmesg we have the normal fun:
> > > > > > > > 
> > > > > > > > > [   15.759932] [drm] amdgpu kernel modesetting enabled.
> > > > > > > > > [   15.760169] amdgpu: Virtual CRAT table created for CPU
> > > > > > > > > [   15.760203] amdgpu: Topology: Add CPU node
> > > > > > > > > [   15.760502] [drm] initializing kernel modesetting (BEIGE_GOBY
> > > > > > > > > 0x1002:0x743F 0x148C:0x2415 0xC1).
> > > > > > > > > [   15.760519] [drm] register mmio base: 0xFB700000
> > > > > > > > > [   15.760520] [drm] register mmio size: 1048576
> > > > > > > > > [   15.764353] [drm] add ip block number 0 <nv_common>
> > > > > > > > > [   15.764355] [drm] add ip block number 1 <gmc_v10_0>
> > > > > > > > > [   15.764357] [drm] add ip block number 2 <navi10_ih>
> > > > > > > > > [   15.764359] [drm] add ip block number 3 <psp>
> > > > > > > > > [   15.764360] [drm] add ip block number 4 <smu>
> > > > > > > > > [   15.764361] [drm] add ip block number 5 <dm>
> > > > > > > > > [   15.764363] [drm] add ip block number 6 <gfx_v10_0>
> > > > > > > > > [   15.764364] [drm] add ip block number 7 <sdma_v5_2>
> > > > > > > > > [   15.764366] [drm] add ip block number 8 <vcn_v3_0>
> > > > > > > > > [   15.764379] resource: resource sanity check: requesting [mem
> > > > > > > > > 0x00000000000c0000-0x00000000000dffff], which spans more than PCI Bus
> > > > > > > > > 0000:00 [mem 0x000d0000-0x000dffff window]
> > > > > > > > > [   15.764383] caller pci_map_rom+0x83/0x220 mapping multiple BARs
> > > > > > > > > [   15.764391] amdgpu 0000:04:00.0: No more image in the PCI ROM
> > > > > > > > > [   15.764412] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from ROM BAR
> > > > > > > > > [   15.764414] amdgpu: ATOM BIOS: 113-001-XT7
> > > > > > > > > [   15.777550] [drm] VCN(0) decode is enabled in VM mode
> > > > > > > > > [   15.781178] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
> > > > > > > > > [   15.781185] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ)
> > > > > > > > > feature disabled as experimental (default)
> > > > > > > > > [   15.781194] amdgpu 0000:04:00.0: amdgpu: PCIE atomic ops is not supported
> > > > > > > > > [   15.781245] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit,
> > > > > > > > > fragment size is 9-bit
> > > > > > > > > [   15.781261] amdgpu 0000:04:00.0: amdgpu: VRAM: 4080M 0x0000008000000000 -
> > > > > > > > > 0x00000080FEFFFFFF (4080M used)
> > > > > > > > > [   15.781264] amdgpu 0000:04:00.0: amdgpu: GART: 512M 0x0000000000000000 -
> > > > > > > > > 0x000000001FFFFFFF
> > > > > > > > > [   15.781277] [drm] Detected VRAM RAM=4080M, BAR=256M
> > > > > > > > > [   15.781279] [drm] RAM width 64bits GDDR6
> > > > > > > > > [   15.783108] [drm] amdgpu: 4080M of VRAM memory ready
> > > > > > > > > [   15.783112] [drm] amdgpu: 5979M of GTT memory ready.
> > > > > > > > > [   15.783133] [drm] GART: num cpu pages 131072, num gpu pages 131072
> > > > > > > > > [   15.783255] [drm] PCIE GART of 512M enabled (table at
> > > > > > > > > 0x0000008000800000).
> > > > > > > > > [   18.564918] random: crng init done
> > > > > > > > > [   19.594908] amdgpu 0000:04:00.0: amdgpu: STB initialized to 2048 entries
> > > > > > > > > [   19.595220] [drm] Loading DMUB firmware via PSP: version=0x02020020
> > > > > > > > > [   19.595937] [drm] use_doorbell being set to: [true]
> > > > > > > > > [   19.595955] [drm] Found VCN firmware Version ENC: 1.31 DEC: 3 VEP: 0
> > > > > > > > > Revision: 2
> > > > > > > > > [   19.595965] amdgpu 0000:04:00.0: amdgpu: Will use PSP to load VCN
> > > > > > > > > firmware
> > > > > > > > > [   19.663643] amdgpu 0000:04:00.0: amdgpu: reserve 0xa00000 from
> > > > > > > > > 0x80fd000000 for PSP TMR
> > > > > > > > > [   19.765435] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is
> > > > > > > > > not available
> > > > > > > > > [   19.781512] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
> > > > > > > > > ucode is not available
> > > > > > > > > [   19.781538] amdgpu 0000:04:00.0: amdgpu: smu driver if version =
> > > > > > > > > 0x0000000d, smu fw if version = 0x00000010, smu fw program = 0, version =
> > > > > > > > > 0x00492400 (73.36.0)
> > > > > > > > > [   19.781544] amdgpu 0000:04:00.0: amdgpu: SMU driver if version not
> > > > > > > > > matched
> > > > > > > > > [   19.781581] amdgpu 0000:04:00.0: amdgpu: use vbios provided pptable
> > > > > > > > > [   19.828182] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
> > > > > > > > > [   19.828795] [drm] Display Core v3.2.281 initialized on DCN 3.0.3
> > > > > > > > > [   19.828798] [drm] DP-HDMI FRL PCON supported
> > > > > > > > > [   19.829988] [drm] DMUB hardware initialized: version=0x02020020
> > > > > > > > > [   19.914675] [drm] kiq ring mec 2 pipe 1 q 0
> > > > > > > > > [   19.956011] amdgpu: HMM registered 4080MB device memory
> > > > > > > > > [   19.963868] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> > > > > > > > > [   19.963883] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
> > > > > > > > > [   19.964255] amdgpu: Virtual CRAT table created for GPU
> > > > > > > > > [   19.964896] amdgpu: Topology: Add dGPU node [0x743f:0x1002]
> > > > > > > > > [   19.964900] kfd kfd: amdgpu: added device 1002:743f
> > > > > > > > > [   19.964919] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 8,
> > > > > > > > > active_cu_number 16
> > > > > > > > > [   19.964924] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0
> > > > > > > > > on hub 0
> > > > > > > > > [   19.964926] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1
> > > > > > > > > on hub 0
> > > > > > > > > [   19.964927] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng
> > > > > > > > > 4 on hub 0
> > > > > > > > > [   19.964929] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng
> > > > > > > > > 5 on hub 0
> > > > > > > > > [   19.964931] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng
> > > > > > > > > 6 on hub 0
> > > > > > > > > [   19.964933] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng
> > > > > > > > > 7 on hub 0
> > > > > > > > > [   19.964935] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng
> > > > > > > > > 8 on hub 0
> > > > > > > > > [   19.964936] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng
> > > > > > > > > 9 on hub 0
> > > > > > > > > [   19.964938] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng
> > > > > > > > > 10 on hub 0
> > > > > > > > > [   19.964940] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng
> > > > > > > > > 11 on hub 0
> > > > > > > > > [   19.964941] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng
> > > > > > > > > 12 on hub 0
> > > > > > > > > [   19.964943] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on
> > > > > > > > > hub 0
> > > > > > > > > [   19.964945] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0
> > > > > > > > > on hub 8
> > > > > > > > > [   19.966250] amdgpu 0000:04:00.0: amdgpu: Using BACO for runtime pm
> > > > > > > > > [   19.966781] [drm] Initialized amdgpu 3.57.0 20150101 for 0000:04:00.0 on
> > > > > > > > > minor 0
> > > > > > > > > [   19.975362] fbcon: amdgpudrmfb (fb0) is primary device
> > > > > > > > > [   19.975369] fbcon: Deferring console take-over
> > > > > > > > > [   19.975373] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer
> > > > > > > > > device
> > > > > > > > So lets see what that looks like on a 6.11.0 without the nomodeset.
> > > > > > > > 
> > > > > > > > Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

