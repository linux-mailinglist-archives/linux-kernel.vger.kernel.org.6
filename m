Return-Path: <linux-kernel+bounces-325515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3DA975AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071DD1F23F33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE1A1B4C46;
	Wed, 11 Sep 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEob9S6l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970329406
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081340; cv=none; b=FwhGpWi5kcSV4hKu8G7m2L7R1O4CAp5NlYgNd541gqPnQ+BX0zunbcpB9RXO+dPxjI5M6Ss6o3qZEFY8yihjwiLzyrS7xdv1H14RfrcCP2Ezg9fzUHU6GzFGQhar87uKbYbm2fzoXkODSOj+NvdQmuXKfmL8jicelIB8sSB07qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081340; c=relaxed/simple;
	bh=OqRWlctVLRA+Uc0IjBjKd06kZ/Gl2JOSWteQyBo8hS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgrwOjVVzW6IvM5prkc7AZ4hfCvvGrvcYubX97Y/EXxpyS4+7tovKuRDik8f2vZAFbDR/oLvsqKbvivX6d4hMcAhpX+EHYpeuHs6ADomGpe5VI22EFk3xSuhv44hM906N8/nrK+KPMz4PFzk7Z0gCpe9aEVAepMiMcHVK9Qi73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEob9S6l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726081337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7bU+mVDP6egUv5mM9Pjy0JHa4eeEo68KAivXsZTIBo=;
	b=ZEob9S6lm16Ltwkt8KGvgheKz7DAfzHprPpP4Yz7E9niT1XuBPKNttQSnGTvrx5nmePR+x
	aHpDSSVhpiWB/ioLGoNmZsDSEMTzF1nRlBZtf0kOdKyHm/iDhTH+IEVZlHS0gJCvO1PlEe
	zpWwHtrFcRnXLhObSa0UsXxBP4jxYV0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-xq0FDl8bPT6m-LT3yPo1lg-1; Wed, 11 Sep 2024 15:02:15 -0400
X-MC-Unique: xq0FDl8bPT6m-LT3yPo1lg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso579355e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726081333; x=1726686133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7bU+mVDP6egUv5mM9Pjy0JHa4eeEo68KAivXsZTIBo=;
        b=a2AiGO6X6hhCtduRd3kNw7HxBbQCu1nSkMaDxxVoVQ1scN2jX38bdMDPekk2StWBqW
         2miivv/pJzUiB9nnV328JhQRscsHj0VXNAtpl4GyNPh4MiJa4cOoyV3vZ0WPIVW0au1X
         LbGmVUvpBQ5jfuNjyHHCzJ6LgGfFsBOUASTJJBj9KSZrkh41PDmaTiL/+rH1FVWOs2HB
         fN/pLMM3WtW6i5wehqfAFP6/P1lEqhkpjO+B7aWC5TTYS5mSZ//GB5JeuOljDflxJyBy
         BK6y/GRriaFPOFvODm8S0aInKXXO0hqsMSYZ/vxPkQ61z3OBI6q2/s2r0RaupSl66C6f
         0TxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOLxrUXFp6acr3+H8K7OM9x2GLOwapsag5dDm7DxZLcno04VaxCU9NJrft5bFa1bMZu3UZByVmgc7n5Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPbIAugnkyzOyIRDX7UYY0g9z9o7YCgG2J63arB/2aZ6k746F
	UTuoK54IWEdpkJlzu2zD6SzMrggq49CkQ9zXIRpvtq3OEXo+Hk0gjLJMX09gMbx73oKOKz5i15e
	MApfdhZXxHILq1fDXlzNW7UPAtLOdKDlcnUxXmqXl04ybVBXGkGnWSjGF/BHWRw==
X-Received: by 2002:a05:600c:3551:b0:42c:af5f:c00c with SMTP id 5b1f17b1804b1-42cdb54b242mr4969185e9.21.1726081333302;
        Wed, 11 Sep 2024 12:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ivWpS+X29Q7R9vEaleEKcy9+v90NgsupdcOLk9j2tmo8P8MX/7b3+Rk8xJX92zcVMmn5kw==
X-Received: by 2002:a05:600c:3551:b0:42c:af5f:c00c with SMTP id 5b1f17b1804b1-42cdb54b242mr4968785e9.21.1726081332434;
        Wed, 11 Sep 2024 12:02:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:d9bb:9070:1995:8d82:f57f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb5a66475sm120162365e9.44.2024.09.11.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:02:11 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:02:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240911150013-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
 <85fb3a90-fbf4-4925-8b53-197f3faa574d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85fb3a90-fbf4-4925-8b53-197f3faa574d@oracle.com>

On Wed, Sep 11, 2024 at 11:20:30AM -0500, Mike Christie wrote:
> If people are ok with something similar as in this patchset where
> we have both vhost_tasks and kthreads, then I can send something.


It would be better, as you say, to modify the vhost_task code so it can
emulate the kthread behavior. However, given that apparently some users
are unhappy, what you describe would be a good stopgap solution
until we have that.

The main difficulty seems to be to describe what the
behaviour is, exactly, so userspace can make informed
decisions on what to use.

-- 
MST


