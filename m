Return-Path: <linux-kernel+bounces-354673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA79940C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CF3B26107
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F6D1CDFB8;
	Tue,  8 Oct 2024 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBQHnKnH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4A1791ED
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372749; cv=none; b=LnB36+IsRphS1WRqBVcM1IFf6E1XAlMjlV5/Y/Sb5Jv3URYimdYH7mHHD8Xq9xiB1kKqUkDcWHmKqaNVPizx/TIpsueFg/e7oNp+0Ch1I1k9FwZydha5Frq2+EsNyFX8lmeUuyn5XYP4KFttg89LFl/1VPhqVVRrUWJgtn0hXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372749; c=relaxed/simple;
	bh=DwhgU5Yy+8M4tb16A5X8DlJ7lDayv35s+EicK1uxF5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV3OY25Mi2Gdp99Ui+rcrf2stQXMMATAE2Md6hc9Lxn+LeQIPmMjp2cIq2ownmnWmAFjjQJn4e/oZRQOuecaA14vEwVtKxU2O/MYGhgV6yYLWWyIOR7ZKLoqOqtgHKqbFlfAFUWrg6Gr3H/rP7gEy5u9/V3xPKOlPBPAaq0RspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBQHnKnH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728372746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUVvUSYhWlp+88sIj5WPfwtDLumv/s1zi3uObWKuh70=;
	b=LBQHnKnHz3xxTaGSRhHFHxiI6v1nnPJvZFNoXQ3y4FY/ZOSSdDIFtawuAHY98xJAvqG5QX
	fcwoIszL6rs/6LQTL8RcLcwMQKfuj0cLhbED+dAhpZfsiYBdRXz1TxkXea2zR2EWqzL1Ik
	iiyP4/ehPSYE6HhQgszTfaLa6cNPUww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-wt_xKxQqMTmTjuQGbrt3Gw-1; Tue, 08 Oct 2024 03:32:25 -0400
X-MC-Unique: wt_xKxQqMTmTjuQGbrt3Gw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd08d3678so2374365f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372744; x=1728977544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUVvUSYhWlp+88sIj5WPfwtDLumv/s1zi3uObWKuh70=;
        b=Uox91oDAl/smK1otUJ8aRzMiNh/+hIYPC17yDEUiN0sK8R+8Ltx3BrX+cJ9vgdeQ1d
         sVCfNrrTwUIjWZ6cgdr0Mxi2E8t6nz4BEmLns246JLfNtU1czUARVTQX4xoFE159zflL
         Qi9WoPMtlicEW0QKiRtcDUi7QjcWI/rm/wASL7T3bFlIUrsMVPmgVXqYOXyz3I/GdHcf
         RtfWLob8kw++bMKiS0aTXHIpxs37567Eet9ssYE5iirqOwxFBOX+3VCxLevEi4S+0m+n
         4gaNDS3rpYe8TL7uMP5QJUQ/T79s4ugVx8XholWQt5G7QxAMphLBxDtFmqUmFs+4PIhq
         ywtw==
X-Forwarded-Encrypted: i=1; AJvYcCVEQl6ErDMjYulfqySUMiLGs8ESoa7ARStcETaLe49yR8U//bG+SOk1iW8AFcQ3nu3qw1CaCTKmViHxSns=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHjHxmxmoF6aTlgHeEqo+sxoT1/dfGqZOyz1hAqgQOH/NMLrl
	wt4r9YyglixKvQAIWZ/mebEwvgQpJhbV0ajx6A5fuBXGXNSap86cGTcENo957jtb07uXY5lFJXt
	I99+MCLpk/hM40/BHXGAIMOwgT0iPT4vGrIwEf5ohdlS266Qm9Oe9nEsD2HrhXg==
X-Received: by 2002:adf:8911:0:b0:37d:34e7:6d22 with SMTP id ffacd0b85a97d-37d34e76e3fmr131227f8f.23.1728372744283;
        Tue, 08 Oct 2024 00:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpCnvtixSaLUfdgYPnnjPQGLPmTjWqJP1lD23M3dwkKjE0komRd6BQG+qeyHuiM222PdHmAw==
X-Received: by 2002:adf:8911:0:b0:37d:34e7:6d22 with SMTP id ffacd0b85a97d-37d34e76e3fmr131205f8f.23.1728372743768;
        Tue, 08 Oct 2024 00:32:23 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697301fsm7326394f8f.100.2024.10.08.00.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:32:23 -0700 (PDT)
Message-ID: <4bd1d414-3f69-44d5-bb41-c44509b38f89@redhat.com>
Date: Tue, 8 Oct 2024 09:32:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/5] TPH and cache direct injection support
To: Michael Chan <michael.chan@broadcom.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, Jonathan.Cameron@huawei.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 alex.williamson@redhat.com, gospo@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20241002165954.128085-1-wei.huang2@amd.com>
 <20241002213555.GA279877@bhelgaas>
 <CACKFLi=ieNNx57i1fG2R6+C1LyXV4oY6=e9AD+Pw-8WtW2X8jw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACKFLi=ieNNx57i1fG2R6+C1LyXV4oY6=e9AD+Pw-8WtW2X8jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/24 00:08, Michael Chan wrote:
> On Wed, Oct 2, 2024 at 2:35 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> I tentatively applied this on pci/tph for v6.13.
>>
>> Not sure what you intend for the bnxt changes, since they depend on
>> the PCI core changes.  I'm happy to merge them via PCI, given acks
>> from Michael and an overall network maintainer.
> 
> The bnxt patch can go in through the PCI tree if Jakub agrees.  Thanks.

I guess the most critical point is to avoid complex conflict at merge 
window time. My understanding it that the conventional way to avoid such 
issue would be sharing a stable branch somewhere with this change on top 
which both the netdev and the PCI tree could pull from.

Cheers,

Paolo


