Return-Path: <linux-kernel+bounces-300442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8595E3B8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8343B21C18
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0800B15530F;
	Sun, 25 Aug 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaWLpZmp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2F8C06
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593916; cv=none; b=hF/0uZXtgchMygEHTVBiM3el9PF852eJ3x9WOpXkzVI+Opnhy4x83UFeWSqRmD/0Q0ktAgwK/pHgb+qLOSnortyTOTe3Jifm0T9B7DL4moWgx76D+IkfSppwF7LiwLVqoNI3LBL9OSX8fwB6WLttlcHA2AypEaqC7z/We+4tl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593916; c=relaxed/simple;
	bh=cxEMb15cvEJg1PIhEqMrDmascCh1VmMYsmZCf7+60cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dts0MkOsQmR66XUrSqatAM8A9q0P7ncRmySZM2vRROm1s26SDIzyEiaj3Es1SajrwfauVG1rxt3l+azUQ2J9F+aa24RkpRqgf7kzEDZpek4KEZDgV0zELbd1cBNslKnJnAtKT5a6836iOOCbmfYz2srbGZHm4f5pWSLRTaxjCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaWLpZmp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724593913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxEMb15cvEJg1PIhEqMrDmascCh1VmMYsmZCf7+60cw=;
	b=XaWLpZmpzLUZFRsCCVBoGsu7zuafa9vwNJG63X661Jo3lLKMTT2xOolDRSu993No5mJcXF
	TZyVAIWAkr8Qvqc2uDw3jXIR9AkgGIaEyo3akR/CyzBlB/I28EdnYAdsIKOWIp6/TMHNeM
	yra9q/TH1abzPDOkzUAAl31hV4eZQYQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-bNF8Kel7PdWL-cwaLc-4jg-1; Sun, 25 Aug 2024 09:51:51 -0400
X-MC-Unique: bNF8Kel7PdWL-cwaLc-4jg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3717cc80ce1so2359454f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724593910; x=1725198710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxEMb15cvEJg1PIhEqMrDmascCh1VmMYsmZCf7+60cw=;
        b=cxNMZazyev9ltRp881+WlR+2YSEXInRkA9Pyf2sO6YioasuBgtsDtFdchpZy6WJ925
         BhA/mXwSIGWJRYbBmID/GrmxoC5WtQKZ70jE8iPTA+GM/v1urEesuq3dkqb/x15Ufibg
         Ef+FFCY3h0DZtUPbMcVVLiJFUzfXBITfh7w0MXx1DsWCkOXNxnHR5bSQ+xzuPHFXCRFP
         eOf5m6flP7RqCnypgrppLV5gNJ4R31e9+hC9/dE5JWGMM9Ny2E6cHSN7mfTS7QVKbZ1r
         bHyWuGiV8V3NRXlvILD8WwvSccIzbqza0JFjyB4aNwRJVdXt55LFhfC2VrzTva0nQD4P
         Dakw==
X-Forwarded-Encrypted: i=1; AJvYcCWbOKYHBp0DmY7jDmlcM1Rrtlgu0f3qf3syV601hJC70IUzlcBxQuTPShw+M9YIi0RWPLbRM2SY1ooN58w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdxNVJVLd6VZVeO/sif0zKGRe+oJt823wDpocgTu287D90wU4
	JfIWkRMivxNTLgGDswWwYYGoetjzQEfvTEa6FjQq5iZY7KD48aYF1KZyIi30+zobxLbzI/7DWAK
	k4hUyRZhK11Kfra6RK3iTRDmcfyr8Z3igHqo3GarupL+BP8W/hCoOTptxe+b3czT5ax1B2kf12O
	iRXeqrcDi01o3snGitFbP5qgoLI/v5+nODZlb6
X-Received: by 2002:a5d:6247:0:b0:371:8d47:c17b with SMTP id ffacd0b85a97d-373118b8b17mr4459164f8f.30.1724593910356;
        Sun, 25 Aug 2024 06:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5Rt2ZGQtty1SlsmajcJ+wRy/l+/mv03lE2W14jpsoR7vK/6p6UGJpKH8n5n/fwUQIRtgECnR6MJjKUVjvz0=
X-Received: by 2002:a5d:6247:0:b0:371:8d47:c17b with SMTP id
 ffacd0b85a97d-373118b8b17mr4459156f8f.30.1724593909881; Sun, 25 Aug 2024
 06:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org>
In-Reply-To: <ZsV17ACIEelIQuKx@infradead.org>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 25 Aug 2024 21:51:13 +0800
Message-ID: <CACLfguX6-q3=ydUsCcaPsS42NiOph6j0zNHVrmpMk2zcMgwQrA@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 13:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 19, 2024 at 05:27:33PM +0800, Cindy Lu wrote:
> > Add a new UAPI to support setting the vhost device to
> > use kthread mode. The user space application needs to use
> > VHOST_SET_USE_KTHREAD to set the mode. This setting must
> > be set before VHOST_SET_OWNER is set.
>
> Usage of an API is a complete kernel internal detail that has absolutely
> no business being exposed to applications.
>
> What is the application visible behavior that the API use is the proxy
> for?
>
The userspace application may need to know the details of the kernel.
For example, some userspaces may use a script to track threads. If
they use task mode, the script may not work properly. In that case,
they can choose Kthread mode.
Thanks
Cindy
>


