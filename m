Return-Path: <linux-kernel+bounces-406777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C797B9C63BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723061F2255E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF6205ABD;
	Tue, 12 Nov 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNcOfESn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E9204930
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447962; cv=none; b=V8Czjy4GzumfY3O0PvkAxWlEr5d/ZtdX9tm/glluwxIoupJ3YWNNlmpnHpufqvHHgIrR29BqdT8psRdqUlOkiiRAyXwFnwWx1ohSzFfK/f3G8hGxAVv9JOSPjYm6FxE4Fcd23nJmO1QGAfNEuAqUiZJWPgUnMGO8aVls5yvrqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447962; c=relaxed/simple;
	bh=XzcSrF6fIKxM7uXU30UXDlxTAJJTRCFxCufcmNnMhI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5jgcLGn1WUnwpDglomRLbJFWq0kqRDAtox1WeumSMlY9XsCzXjv5xV8a+U11pHFwhm2IaUt9S30rFgzCaK19m/KOa/DxKBsdI6+U0rRpfQJA1TiKpr+0LUnLCkaRMB4Dh2Gfgg5iCOzWSyRLMLZqAJqDBoxf6lxuxqfajk4qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNcOfESn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731447958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEXKPYAc3peE3acn5QFpQ/umi0YhyN29WLWtIZ8OcXM=;
	b=eNcOfESn609boXvxeyp2fahRFfPqgdMdGSszVRw+QnttggO6YFH1Eewg0jIRwK0GuOA+zQ
	Ny6nKAzmeGpOqXT7nfIOLsz/kFeKreZrudHTrs6xvYWubv9Oc4zz0ueK1fJvVaoj501Wn5
	WlPMDjRYxxsTi7fu1iax3sNkIOsJMlA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-9veDiwiMN0yaS-UYJmaeBA-1; Tue, 12 Nov 2024 16:45:57 -0500
X-MC-Unique: 9veDiwiMN0yaS-UYJmaeBA-1
X-Mimecast-MFC-AGG-ID: 9veDiwiMN0yaS-UYJmaeBA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso42380545e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731447956; x=1732052756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEXKPYAc3peE3acn5QFpQ/umi0YhyN29WLWtIZ8OcXM=;
        b=fi39zDCFXCquf1BdZSUHwdrUADJcfDHK77cFNSXaxXwyWR8byj/QpTMwJbI1gb7grT
         /18ebx8JurxqVRZ930sPFT4ldsMYYvZR1SgNHm2+PbySNb6OSy6k8tnhm9rETOWeC2A6
         glyfrwZnjOfT15NAjoOy/BSdX4d/9hnJtHJ7FcmoLR22gPFuTTEwkX30sR/i1DNZXp1i
         MoOy+jIFo2oBxWMfTb/hsARg0/SCmqawxGX8PD+pY5RFsmkw+mIciVQewThHBKIgzB45
         3+EgHExzn77W2OOqLzd4T+iInQ6QCmPeQY392bMx4I2/KNg/EwYsPyCGgb30lV5OcXaa
         6UvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKu42zQazJuRcOs3DLa9fhE6axyiV91BN73RqOxKN+Oz0Hu22rjoT622jhLQa9KXYJ9YVuviY7cnROeAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoIOUKe9E431/4NgqjpFe7zfBpHU3cjk5dpt3dbP1yawag+1H
	skvzw/nczXI+kTiqA/gxBRorIYA5gTfUHSUg+S3+jNmqeTYi6mzEZPIOJG4ltwgyQOTSPArDr3W
	t6gkQSPNMLi1EteWv8VQOP7IDtBKXAQz537o1st7gaKoXWC5GSMYQtRO4Zdpnsg==
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr14710788f8f.47.1731447955906;
        Tue, 12 Nov 2024 13:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4LGnvjV0VuCH9YfFtTizkXe46PL/o3H5AzRLIPG709DaWPYimrxeFeOhgxLEtRISOMi8Iqg==
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr14710779f8f.47.1731447955557;
        Tue, 12 Nov 2024 13:45:55 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9978c6sm16376608f8f.50.2024.11.12.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:45:54 -0800 (PST)
Date: Tue, 12 Nov 2024 16:45:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
Message-ID: <20241112164527-mutt-send-email-mst@kernel.org>
References: <20241111025538.2837-1-jasowang@redhat.com>
 <20241111022931-mutt-send-email-mst@kernel.org>
 <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com>

On Mon, Nov 11, 2024 at 04:36:52PM +0800, Jason Wang wrote:
> On Mon, Nov 11, 2024 at 3:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > > There's no need to sync DMA for CPU on mapping errors. So this patch
> > > skips the CPU sync in the error handling path of DMA mapping.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > DMA sync is idempotent.
> > Extra work for slow path.  Why do we bother?
> 
> dma_map_sg() did this, since current virtio hack sg mappings to per
> page mapping, we lose such optimization.
> 
> Actually the path is not necessarily slowpath in some setups like
> swiotlb or VDUSE.
> 
> Thanks

I don't get how it's not a slowpath. Example?

-- 
MST


