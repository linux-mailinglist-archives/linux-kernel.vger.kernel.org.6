Return-Path: <linux-kernel+bounces-265135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBAC93ED35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92771C211F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE183A19;
	Mon, 29 Jul 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eTmc8bnk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FC7E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233620; cv=none; b=VEKe0SoXuj7p9S4NRaUplX4OwGF2gj9D96W55rugr9uUnIVPUvt41koHY1T3ENBp0H6lasBlnyBAJKvt6uXMcwJnx5KYEe4WeS8bR8bYllpkY5l6EnTsltjKRN/LLn7lBEF5DS+1wlUwYHnbF36BQCd3nGhALsxHfXJ2z2PcMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233620; c=relaxed/simple;
	bh=1gKt2Swq1D4y2sR60aNgUnEJEx1mYdlpzvHxMg/ZPgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khqpVsymc+vClSqiY3LAcZR0sOHaxQLh8JHGyjlzrpxcihwFFzB9dKby1BEz6bh6NK6wxBIERxJ6+F0TahyeoYT3Xn/qvQVd3apDPeG2Mnz0h2iqxANMxM41tocuNorP4SrL8UNN4L4TVxjBl80OYD6ZWP2MOUmUiNl4TFPVCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eTmc8bnk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso3493883e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722233615; x=1722838415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gt8S7NT/TrfoaEFacqUybne4Hiq3S5hwIbYpqxtHkDs=;
        b=eTmc8bnkY8tEvFPHdNrR46Lua6MpVPlaGrScqQVo7yMGsHnStDMOVFBVjlgDSKIZDv
         cu9afRuIHfWMsGZLUt7cTU84Lq2GaT6/an6FYxtBIlsr1j3fAwEAb1mS7rcrleOPG/fB
         AjTs9B1PdadcRKa79g5woeGmruke2EOtZ5yKpBgkgqNFmCPL09Gk06uTq8cyKkEew0o3
         FPH8dHiuma71ZWhTNhHwaWoduRvaLGnoCsFSJuDy0SuFjSmfszuDyo88l77ruRs9aD2t
         0b8mr+Wn/ZYTojChYh3bhVKDRxxRwXXKWNysjykP0GDTb5FqKnCqixEou4cNgBXLIIm2
         3vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722233615; x=1722838415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8S7NT/TrfoaEFacqUybne4Hiq3S5hwIbYpqxtHkDs=;
        b=TXIxOQDl9E0flRpkASq5E8Q0cIHkkD+S8G1t1snuAQDIwxJJimzsrCUpIguCsbxR3p
         UxAw/m6N4jDhwbBvYi+Fa6mf0mifpyWuRParekJVWrzaAk34FqMESTtAbJOd+Suqmxzx
         sw+CVYEN+ym48Jf1Jas9HPJTPjPtJiM2FcScchSgNoPl8safh0bHPDu/BKtkLXhO3kIf
         zNmLtTHDTPZ2cybM0reep7GEs893xa1R2TfwOhRX39lYDFjfXy0fBWXNxTbnLtrKg+lY
         CZ3pdHI6RZkubh7umToJ13BRw+tWIntfRDE/G4TmVWzHPdceSAwpnLhz/BSSVSJSCtOu
         8Hmg==
X-Forwarded-Encrypted: i=1; AJvYcCWldjiII38x5N1r8h0sI0MFlLFUBtXkilS06TykUxD6aFjD43PJIbNZKwhkptY7socYVofoV7YOSlRFPDtirVpEG80J49KJHzleyY9Y
X-Gm-Message-State: AOJu0YwYErOj8mYkS5WgJPAl9FFwnc0tbdAfmgxaVzEBmAXA3PwDLcoq
	h7pbeOMzD19NVWLweACeNVywV0fb/OaxfCUZtSVOUedeNX/aT6JJIN3gVYqNW0dHNMgoka3bDAa
	+
X-Google-Smtp-Source: AGHT+IFAwo3EiCjnUkYHAH2CNpPE9QYcSmm7YFNs/AIYDKbze6CS5ScJvoRSCHbKNV6gRIxxA/NsBg==
X-Received: by 2002:a05:6512:32c7:b0:52e:943c:c61a with SMTP id 2adb3069b0e04-5309b2e0adbmr4950063e87.57.1722233615178;
        Sun, 28 Jul 2024 23:13:35 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8356sm460401266b.206.2024.07.28.23.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:13:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:13:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Message-ID: <ZqczDQ_qAjOGmBk0@tiehlicka>
References: <20240726084456.1309928-1-lizhijian@fujitsu.com>
 <ZqNpwz5UW44WOdHr@tiehlicka>
 <fd6e84d5-9dba-47fb-a39e-1f7f0995fdf5@fujitsu.com>
 <2ab277af-06ed-41a9-a2b4-91dd1ffce733@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab277af-06ed-41a9-a2b4-91dd1ffce733@fujitsu.com>

On Mon 29-07-24 02:14:13, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 29/07/2024 08:37, Li Zhijian wrote:
> > Michal,
> > 
> > Sorry to the late reply.
> > 
> > 
> > On 26/07/2024 17:17, Michal Hocko wrote:
> >> On Fri 26-07-24 16:44:56, Li Zhijian wrote:
> >>> When a process is bound to a node that is being hot-removed, any memory
> >>> allocation attempts from that node should fail gracefully without
> >>> triggering the OOM-killer. However, the current behavior can cause the
> >>> oom-killer to be invoked, leading to the termination of processes on other
> >>> nodes, even when there is sufficient memory available in the system.
> >>
> >> But you said they are bound to the node that is offlined.
> >>> Prevent the oom-killer from being triggered by processes bound to a
> >>> node undergoing hot-remove operations. Instead, the allocation attempts
> >>> from the offlining node will simply fail, allowing the process to handle
> >>> the failure appropriately without causing disruption to the system.
> >>
> >> NAK.
> >>
> >> Also it is not really clear why process of offlining should behave any
> >> different from after the node is offlined. Could you describe an actual
> >> problem you are facing with much more details please?
> > 
> > We encountered that some processes(including some system critical services, for example sshd, rsyslogd, login)
> > were killed during our memory hot-remove testing. Our test program are described previous mail[1]
> > 
> > In short, we have 3 memory nodes, node0 and node1 are DRAM, while node2 is CXL volatile memory that is onlined
> > to ZONE_MOVABLE. When we attempted to remove the node2, oom-killed was invoked to kill other processes
> > (sshd, rsyslogd, login) even though there is enough memory on node0+node1.

What are sizes of those nodes, how much memory does the testing program
consumes and do you have oom report without the patch applied?

-- 
Michal Hocko
SUSE Labs

