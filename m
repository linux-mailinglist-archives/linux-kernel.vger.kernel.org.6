Return-Path: <linux-kernel+bounces-311379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EDA968858
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54442281E80
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294E205E1A;
	Mon,  2 Sep 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+ixLrY6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A969D200138
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282219; cv=none; b=jeRCpjiQfNyvwGJ5iin/isRVsSEni7IaY+l6QKAGlMK7vPyJpzaaPk/bOY1h333UDLZah/xDwcjh/sGImWwQM9pwObNsIWKx1yNgO6jPMgwFjJJIZWr1pKbQKwmmwvCmZS4H2L3tab+0jqYrZ+c4HF+MGs08jsFW48LwrTpr4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282219; c=relaxed/simple;
	bh=LbAS4FZyS6/+38yTr+obAQZuT3vj6lpAY3dxb6rP7K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfseWe0akh/nAL2w5hvvic7v0YZRV7u3lWnx0kDFBfwOEKPrjOyH3mj2HN5xe85WOiT/hvANx7L69n0CLxWYy5wIEIjxYJh4obBz5tZWkoHITlaZoFXQ9hrOHQNOvxql8DPPOpTfUCSuFkk5bQKu1OF7K8WCvDpL8fUcDEYvxuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+ixLrY6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725282216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQAIKVHexr0ml0E9tU9s6jAH+3r1zviEqDoOy8RQCGk=;
	b=X+ixLrY6ulA/DceAUmRIl+tEylvzTt1dr6y3TLoIZ8CiEnJL8H9NoVtACj8K8CMYTEbHXV
	d9t/yGr+fvoFpmaB3WlHEzkqMeVos3AlO8bE+oW90InvaiOqKr0erMjL0Rcs7zbX4OpkCJ
	PctOnHCWqp5tahVOxgTA6vuqEqjIBOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-8Erceh3fNMy8CxeGQeh_9w-1; Mon, 02 Sep 2024 09:03:33 -0400
X-MC-Unique: 8Erceh3fNMy8CxeGQeh_9w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42c7a5563cfso17145215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282212; x=1725887012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQAIKVHexr0ml0E9tU9s6jAH+3r1zviEqDoOy8RQCGk=;
        b=Cq5ijtzefafDL3gc2SQlg4r6Zzd0y0U+shxuzEKYNbKeDS4jJwLRH8zQruMbq0l1to
         ixgFayUGbxqo+6hLe+PVwbnDJjNfVaK0isu/10dRPeFBa37gbo4uz1wh1zRrpp0iStCG
         ntSroAL0q/r/+QAB1v0cWQhdfcOf7KIkM4HZROwQaCb2Fw1FzWDyToQmnVPQEMkahMuU
         WrswdDeQijc3mRC7kvN5UYxM5H/r8KBMIzMlv2EsBYFVGyVHgxNI7rXMccMW0dfHhmYS
         EiLH3HUpV9l7Dblv1Ww0gEpbecwt66uGViD+4wQoCw/5iTfb4s3dgbMs/6Y5xQGiAszU
         7TLg==
X-Forwarded-Encrypted: i=1; AJvYcCXq84X5XupqPhk0bT6Mdo+hdI6XV2KUxi9xSmSDiLryHP0q6OtViLOPcPDjQaRrRWZEfKkwyr3NHyiDEXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykcSMSGiKmzyp7YqOGNfbFFlown3au5W5NCFKsCslCa+vIGtCD
	/Y3a+/fO1VaQDQ+PIQvZLnhQnRuB9x8QaIMKf+49ZazbQ+LKLuy56xuJmluuBVB0Oa3A0D7Fky6
	RO72o7oA2BJUZSnJ3wTXu/Zd079kZ/HUlkRluFKTet+DLE0QxlYTEtUqGS3dc/X0K4R0cZahxT5
	8TWcI9dVeg7WJbyKxHDfB+NBGnozt6W/DvDpP/
X-Received: by 2002:a05:6000:144e:b0:374:d2a3:9806 with SMTP id ffacd0b85a97d-374d2a3989cmr170717f8f.2.1725282211716;
        Mon, 02 Sep 2024 06:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCPqJZ/CvAvLM7TGzyZHJgxy1cF8dLQS4WbCTRfzmv3GCHS1hWrWyE639VzeQdgwR4dXgAIimd0g/UARxnRXE=
X-Received: by 2002:a05:6000:144e:b0:374:d2a3:9806 with SMTP id
 ffacd0b85a97d-374d2a3989cmr170686f8f.2.1725282211256; Mon, 02 Sep 2024
 06:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608000639.3295768-1-seanjc@google.com> <20240608000639.3295768-2-seanjc@google.com>
 <efb9af41-21ed-4b97-8c67-40d6cda10484@redhat.com> <Zr4TPVQ_SNEKyfUz@google.com>
 <CABgObfZSCZ-dgK3zWao573+RmZSPhnaoMsrify9-48UVhbKVdw@mail.gmail.com> <ZtJZjIRdiN8e5_Es@google.com>
In-Reply-To: <ZtJZjIRdiN8e5_Es@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 15:03:19 +0200
Message-ID: <CABgObfZ4XD=yQ3kRiNnMfd=w0ZbGY3yzTz49s-Kq4CKE+QJXxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] KVM: Use dedicated mutex to protect
 kvm_usage_count to avoid deadlock
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 1:45=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> > Can you add a comment to the comment message suggesting switching the v=
m_list
> > to RCU? All the occurrences of list_for_each_entry(..., &vm_list, ...) =
seem
> > amenable to that, and it should be as easy to stick all or part of
> > kvm_destroy_vm() behind call_rcu().
>
> +1 to the idea of making vm_list RCU-protected, though I think we'd want =
to use
> SRCU, e.g. set_nx_huge_pages() currently takes eash VM's slots_lock while=
 purging
> possible NX hugepages.

Ah, for that I was thinking of wrapping everything with
kvm_get_kvm_safe()/rcu_read_unlock() and kvm_put_kvm/rcu_read_lock().
Avoiding zero refcounts is safer and generally these visits are not
hot code.

> And I think kvm_destroy_vm() can simply do a synchronize_srcu() after rem=
oving
> the VM from the list.  Trying to put kvm_destroy_vm() into an RCU callbac=
k would
> probably be a bit of a disaster, e.g. kvm-intel.ko in particular currentl=
y does
> some rather nasty things while destory a VM.

If all iteration is guarded by kvm_get_kvm_safe(), probably you can
defer only the reclaiming part  (i.e. the part after
kvm_destroy_devices()) which is a lot easier to audit.

Anyhow, I took a look at the v2 and it looks good.

Paolo


