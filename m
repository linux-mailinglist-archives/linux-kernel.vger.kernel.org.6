Return-Path: <linux-kernel+bounces-218626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788490C2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC251C21857
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D219ADBF;
	Tue, 18 Jun 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MQync8Ka"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F305210FB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718684704; cv=none; b=PaOb/dOWl9KuZVGmzmI1WLVraly+CkWWiQQW1d8JwPF4nCWTzcpI8GEHcUHXUKvW3lVF3QkGXLNRRld6jjdIX2oZ8c8se2DomtfM7mG8toHbu9DGPqHtJoqWt+hTcP5+2F1ufNmP56aVwiD/BXW1VoTEC/gy7ro5CRFYXIPe7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718684704; c=relaxed/simple;
	bh=+b2kXCUfsf2g4619ygnTCbnlP7qe0wWywZPtttOQKzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=okL2/rDhRODadZA/VIij4J5tHQ9Lp/6392fVZYIWQ3dnK78I6dFfKFGp8M5GGgsHmMnmHbyyqRi9t2ZzU1g4Z5m1VPktoc2lFNnTIoTjY59AO/+6ziZX5cbHeFIDDwVvQgOUxefpOJ0S/AkV9wwUlAeeSewwBSUoTUQ5LtpoNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MQync8Ka; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240618042458epoutp01495f7c0fc517ccf1f6bc81d8d4b5983e~Z-qCAEDs-1240412404epoutp01u
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240618042458epoutp01495f7c0fc517ccf1f6bc81d8d4b5983e~Z-qCAEDs-1240412404epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718684698;
	bh=vB1bAHIdtk0etp7sNOGy2K2uwCH5ZON2u2W/CFR2QJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MQync8Ka0m6i6NdXu2PI0NaoeNBdF/D8rsKeHWZrECvTL8Zj2+/EDPtZohFhCyCwN
	 xHD9+GP4h/FNAktDQtGnl75/V6gywpzO2MvVA/arQ+FvWOEet7TAxUoPoazhE2zpRF
	 Nhnb+aaw7yNfHq93DNITYqUb+WhhLM6Qj50l1oh0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240618042457epcas2p230ba70ac20df5f694d86ca97f5792bad~Z-qByvx1f2866928669epcas2p2I;
	Tue, 18 Jun 2024 04:24:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W3DDn2XPqz4x9Py; Tue, 18 Jun
	2024 04:24:57 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	C8.8C.09479.91C01766; Tue, 18 Jun 2024 13:24:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240618042456epcas2p45678af844d2c1140e5fe9a2383e200f9~Z-qA5vJl52983429834epcas2p4p;
	Tue, 18 Jun 2024 04:24:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240618042456epsmtrp16d99dcbf0cacbc71d4bc7381a807f5b9~Z-qA2DI_I1892318923epsmtrp1i;
	Tue, 18 Jun 2024 04:24:56 +0000 (GMT)
X-AuditID: b6c32a48-105fa70000002507-53-66710c191b3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.D8.07412.81C01766; Tue, 18 Jun 2024 13:24:56 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240618042456epsmtip143cc251a975a0e53c164ee2969700109~Z-qAp8L1a0337703377epsmtip1L;
	Tue, 18 Jun 2024 04:24:56 +0000 (GMT)
Date: Tue, 18 Jun 2024 13:24:29 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: joswang <joswang1221@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jos Wang
	<joswang@lenovo.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read
 timeout
Message-ID: <20240618042429.GA190639@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240618000502.n3elxua2is3u7bq2@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmha4kT2GawZJnAhbNi9ezWdx/y27R
	fW0Pk8XlXXPYLBYta2W2WLDxEaPFqgUH2B3YPXbOusvucfbXS2aP/XPXsHts2f+Z0ePzJrkA
	1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
	yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
	2Rnb9t9jKeiVqDj+qYmpgXGCcBcjJ4eEgInEjVsPmboYuTiEBHYwSmxo7GaDcD4xSpzaOIUd
	wvnGKNGzqoUZpuX+1m1QVXsZJTr+LYNynjBKTNx3HqyKRUBV4sexfjYQm01AS+LejxNgcREB
	HYkDJ86DLWQWmM0kMff3Q8YuRg4OYQF/iSUbJEBqeIFq5p3axw5hC0qcnPmEBcTmFLCWOL56
	CxNIuaiAisSrg/UQB/VySMy6Fwdhu0hcubOdDcIWlnh1fAs7hC0l8bK/Dcoulrj1/BkzyAkS
	Ai2MEitewXxmLDHrWTsjiM0skCHxe/0nsNMkBJQljtxigQjzSXQc/ssOEeaV6GgTguhUlph+
	eQIrhC0pcfD1OaiJHhJXZ0yFBuJdJonGtnmsExjlZyH5bBaSbbOAxjILaEqs36UPEZaXaN46
	mxkiLC2x/B8HkooFjGyrGMVSC4pz01OLjQpM4PGenJ+7iRGcVrU8djDOfvtB7xAjEwfjIUYJ
	DmYlEV6naXlpQrwpiZVVqUX58UWlOanFhxhNgTE2kVlKNDkfmNjzSuINTSwNTMzMDM2NTA3M
	lcR577XOTRESSE8sSc1OTS1ILYLpY+LglGpg0rmZujmCQ1FHYu8sfZV3J/icG+UdJxwx8SmO
	FjN3y1Q87N85Y4fchnff3/6Y/CDzvlD6rEDuFMG306Yrdm9d332qa27yJEWBwM0aJ/aUdS5x
	iogOySnW6yj54safzro8/05BeoFFpxLX4tPdVa++1K59tjj5VtYc6fj9DYfDQzbM+OB16P7k
	3SuvT+FN3Gw3Jcxb/1RUgPpbT3vmPhG+tdqfKrgEOOcrqabHnNOI959Wlu82+X7h+j/5nzeJ
	nrzadqgsLY3hq9685QemGOskzeTTCol0ffxrSu3qFkFJjrmMXtKvH+1USVvbx3slZCoHMMvG
	XXh3XupkOwP/3z3qmtXbwmf7zvn8emrMRWYlluKMREMt5qLiRACrWFcQNAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnK4ET2Gawc9+fYvmxevZLO6/Zbfo
	vraHyeLyrjlsFouWtTJbLNj4iNFi1YID7A7sHjtn3WX3OPvrJbPH/rlr2D227P/M6PF5k1wA
	axSXTUpqTmZZapG+XQJXxva2j4wF60Urzj3ax9bAeE6gi5GTQ0LAROL+1m1sILaQwG5GiXvT
	aiDikhJL595gh7CFJe63HGHtYuQCqnnEKPHk1SIWkASLgKrEj2P9YM1sAloS936cYAaxRQR0
	JA6cOM8E0sAsMJtJ4ty9FYwgCWEBX4nz+3rAbF6gonmn9rFDTL3LJPF5wVM2iISgxMmZT8A2
	MAuoS/yZdwloKgeQLS2x/B8HRFheonnrbLBlnALWEsdXb2ECKREVUJF4dbB+AqPQLCSDZiEZ
	NAth0CwkgxYwsqxilEwtKM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAiOGC2NHYz35v/TO8TI
	xMF4iFGCg1lJhNdpWl6aEG9KYmVValF+fFFpTmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KL
	YLJMHJxSDUxGvhvnsq3ekvpV/lvYcx133trpFm3CDyJaFtqx6hSmnvzyaluM6MZ93L9mKnJJ
	HDXZobB5md5s25KFfkExWYJz/7D/io7WNvItFj54ILLx3onFy26YHMl8FxXOuEl7e84iLv00
	hwNbNlS6739tq5T/QsJpi2doEvd76Qsi/5lzjKbc51n5mlOChaXE2XDCynvblf9dsM2Z9jlM
	5svejolHTA6bqfz0v71t7oIXNucdwieWhB1YcuNvdZ/b8e/SDMkvMwvfHnZY7nR4svjqQNut
	OVOFz7gl7PaYf/PXywdJiz9+Wn1Hpj83v9+5OT3ispby33sLb4tuEY0XzdiyUlPjd4uhqbyO
	0uIKkWWrCncosRRnJBpqMRcVJwIANhcXkQcDAAA=
X-CMS-MailID: 20240618042456epcas2p45678af844d2c1140e5fe9a2383e200f9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_d358d_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240618000530epcas2p15ee3deff0d07c8b8710bf909bdc82a50
References: <20240601092646.52139-1-joswang1221@gmail.com>
	<20240612153922.2531-1-joswang1221@gmail.com>
	<2024061203-good-sneeze-f118@gregkh>
	<CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
	<CGME20240618000530epcas2p15ee3deff0d07c8b8710bf909bdc82a50@epcas2p1.samsung.com>
	<20240618000502.n3elxua2is3u7bq2@synopsys.com>

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_d358d_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Jun 18, 2024 at 12:05:05AM +0000, Thinh Nguyen wrote:
> On Thu, Jun 13, 2024, joswang wrote:
> > On Thu, Jun 13, 2024 at 1:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 11:39:22PM +0800, joswang wrote:
> > > > From: Jos Wang <joswang@lenovo.com>
> > > >
> > > > This is a workaround for STAR 4846132, which only affects
> > > > DWC_usb31 version2.00a operating in host mode.
> > > >
> > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > in host mode that would cause a CSR read timeout When CSR
> > > > read coincides with RAM Clock Gating Entry. By disable
> > > > Clock Gating, sacrificing power consumption for normal
> > > > operation.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > ---
> > > > v1 -> v2:
> > > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch,
> > > >   this patch does not make any changes
> > > > v2 -> v3:
> > > > - code refactor
> > > > - modify comment, add STAR number, workaround applied in host mode
> > > > - modify commit message, add STAR number, workaround applied in host mode
> > > > - modify Author Jos Wang
> > > > v3 -> v4:
> > > > - modify commit message, add Cc: stable@vger.kernel.org
> > >
> > > This thread is crazy, look at:
> > >         https://urldefense.com/v3/__https://lore.kernel.org/all/20240612153922.2531-1-joswang1221@gmail.com/__;!!A4F2R9G_pg!a29V9NsG_rMKPnub-JtIe5I_lAoJmzK8dgo3UK-qD_xpT_TOgyPb6LkEMkIsijsDKIgdxB_QVLW_MwtdQLnyvOujOA$ 
> > > for how it looks.  How do I pick out the proper patches to review/apply
> > > there at all?  What would you do if you were in my position except just
> > > delete the whole thing?
> > >
> > > Just properly submit new versions of patches (hint, without the ','), as
> > > the documentation file says to, as new threads each time, with all
> > > commits, and all should be fine.
> > >
> > > We even have tools that can do this for you semi-automatically, why not
> > > use them?
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > We apologize for any inconvenience this may cause.
> > The following incorrect operation caused the problem you mentioned:
> > git send-email --in-reply-to command sends the new version patch
> > git format-patch --subject-prefix='PATCH v3
> > 
> > Should I resend the v5 patch now?
> 
> Please send this as a stand-alone patch outside of the series as v5. (ie.
> remove the "3/3"). I still need to review the other issue of the series.
> 
> Thanks,
> Thinh

Hi Thinh,

We faced similar issue on DRD mode operating as device.
Could you check it internally?
Case: 01635304

Best Regards,
Jung Daehwan

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_d358d_
Content-Type: text/plain; charset="utf-8"


------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_d358d_--

