Return-Path: <linux-kernel+bounces-561633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F93A61461
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D501B62359
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF6C2010EE;
	Fri, 14 Mar 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ug50TmXm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AA20101E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964416; cv=none; b=BZ46o+EcUXHfXDGPw+itYtI2/usStCuNV2L0HtCa8lRJvDy3ZIo274vQ+rPmdUjh03BFDyjkyx5nP13SGaY9TV/SEwB4iTvtml0iKWXOQmxGN4Aar0KJGmJzprbq1ri8xGQGTDUoFSaM7AyIrdE5bZQNshSNzlvVMg9odd6lj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964416; c=relaxed/simple;
	bh=wVO9ce9ZlRAVIzi8gnvoeWyyJtrFVY+UI1wkCjaHpb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8cfgyVCcTvB5m7JsNEe+U4thEK8/PbnJ6pCgZudL74EB4fZ5mga5kmaFXXABzXb7WNZ3w6Ka68a0Io4TxR68vMUTmOBkw1f2tpaqzbAmZfiohSDCB02DiazvXVp/S4nOj5ZSO8VnluqswtI1rvXg0118a17zUKzZycJw9+mzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ug50TmXm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so816740a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741964413; x=1742569213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVSx58DsHtkAMotnaLKAEooZxKwTq9f+R9xk+PmCQj4=;
        b=Ug50TmXmfbKkgxpUWizNvvpPF3dyn0bBPtrnYCiXcmNhEUoenyfqGTM6DvrCWP5yUc
         gLZZMXv0I5ztPv6FXaC6KieYxHP0TcJA1gklu2LVqL8QP4gPugBAHnPpg57JSMP3MzA+
         VIQcB3mZcXvnXzqbzIUUJUPFTINHwil37eb+DiyfBz/KF8xlRfeQWSfuOHyJDhprt+b2
         +65oJflC9zS2Y3EaHMXgVfc1jqyKpsRUjupG+SI17Deu1h0/MV8j0vHmTg7Y+t1kRzxE
         NgmQVZnaOqsOB2+t1KkuadMIku/HgJ01SqmWGv/0OqEjpd7bkKF06NjotDEOulivVc0X
         h5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964413; x=1742569213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVSx58DsHtkAMotnaLKAEooZxKwTq9f+R9xk+PmCQj4=;
        b=VElgruGGav1rJttbheFCCXfAB9Dft8koKsrQSsAlboFi2rbj3QeT/YK/onsPzd1ExN
         lq6Z3H96pzIHLj01NmtIQZ7eXuNSfaZp3HiLGz6o4TDzbkYEkfSugq1HPzP85N/uqu4A
         uuSqy21UgshbihXYvFPdgezAOFueybQ05lixEIYJIikJixroHEy7x5RUGv3FUvwFcDZY
         D77YDWsfflsVt0cWwkmRtmqNN82kA86xQLovqaFZ/SL9U1AQWMFnyvxLRHf9V8G26XVT
         zxowWnOOC9KyZFg6y9i5FoslLIwJ/xlErX7PXonH1FWQLOpq0VjPXLbqHiMaoCWrQ/WX
         7PKw==
X-Forwarded-Encrypted: i=1; AJvYcCV0DlsEjjd8hXXNw5XFTNS8nErEVg2LOZfkyx3660tpoWJu2Ol/+n3K1+UpkqhUMdEK65uaZGOMqHlFlTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NCgarGWq6ccfhMyRObQhWwEyBLteaiJQg3rL65HjoF+i3eAV
	oQAsFAhqkbBu4z/zKElVBMlGjp2B8Dm3s8Iz0LjuDJbZ/oQzYqT40iGVt0Aedg==
X-Gm-Gg: ASbGncts+JI8nVbfzEUg/lpIGGFWrn3hfgq0H1bS+JmY2yIntwef2ljn1QFK+/jl56u
	vnCT4ozDsF4pXfesANU8hCAUbPPTUqXrxWLjxCJGQSeNcGqCFUTT6ziBdLb9802b5wP6giW3Adu
	7USyzpdpqLCOz94rbc5X/IKNykMMYHwjxsMk6vpNOZpv82B1YOzGF5hFvqDWrIoGRjs8xPQ57Uy
	c3saswPSUh/sWh2yt+bItsDwsDQkmKqg2aE73TVyrP1ptxAiSNycv38JGQvFXJ8zuQENHQtaxfy
	y56oYX3iCqoEPvRh1PGkUJYC5kemiOrJBvC64xfqM2mO8OViVrjG3SYG
X-Google-Smtp-Source: AGHT+IGXi5pJN6hlN3/mXEHRZ3EVVSDKdTJMkkncbCWed/2kKH5Frpp3CpqUy6VX2Tj7ji39o+bPMA==
X-Received: by 2002:a17:90b:3a08:b0:2fe:8217:2da6 with SMTP id 98e67ed59e1d1-30151d9d6eemr3264998a91.22.1741964412845;
        Fri, 14 Mar 2025 08:00:12 -0700 (PDT)
Received: from thinkpad ([120.56.195.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539e9817sm1085872a91.13.2025.03.14.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:00:12 -0700 (PDT)
Date: Fri, 14 Mar 2025 20:30:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v7 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Message-ID: <20250314150006.crjestg3rtxu726q@thinkpad>
References: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
 <20250225-preset_v6-v7-2-a593f3ef3951@oss.qualcomm.com>
 <20250306032250.vzfhznmionz3qkx7@thinkpad>
 <9be6ce8e-f0e2-7226-e900-3a0c2506a16a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9be6ce8e-f0e2-7226-e900-3a0c2506a16a@oss.qualcomm.com>

On Tue, Mar 11, 2025 at 04:31:33PM +0530, Krishna Chaitanya Chundru wrote:

[...]

> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 01e51db8d285..c8d44b21ef03 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -9,6 +9,8 @@ struct pcie_tlp_log;
> > >   /* Number of possible devfns: 0.0 to 1f.7 inclusive */
> > >   #define MAX_NR_DEVFNS 256
> > > +#define MAX_NR_LANES 16
> > > +
> > >   #define PCI_FIND_CAP_TTL	48
> > >   #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> > > @@ -808,6 +810,20 @@ static inline u64 pci_rebar_size_to_bytes(int size)
> > >   struct device_node;
> > > +#define PCI_EQ_RESV	0xff
> > > +
> > > +enum equalization_preset_type {
> > 
> > For the sake of completeness, you should add EQ_PRESET_TYPE_8GTS also. You could
> > skip it while reading the of_property_read_u8_array().
> Can we add like this to make parsing logic easier otherwise while
> deference the presets array we need to subtract -1.

Without EQ_PRESET_TYPE_8GTS, it would look like a missing enum. So someone will
add EQ_PRESET_TYPE_8GTS in the future and it will break the driver. So be
prepared for it. 

> currently we are using like this presets[EQ_PRESET_TYPE_16GTS] if
> we want to keep in same way we need to use like below.
> 
> 	EQ_PRESET_TYPE_8GTS,
> 	EQ_PRESET_TYPE_16GTS = 0,

No. First enum element should be initialized with 0.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

