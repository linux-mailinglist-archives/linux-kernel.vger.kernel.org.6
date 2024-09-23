Return-Path: <linux-kernel+bounces-335354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB297E486
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5363281264
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03A1C36;
	Mon, 23 Sep 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlvSAj0l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2738624
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054196; cv=none; b=K195KW7ynESyoMs9Tv7NxPHNGiV9hWQVqVH3F0I8d8+FT/wOCL7cSlvvqlB54RVNLtsl9iIbl7nLscNrDErFQWqQ4ZIkFbOYrsx3Kvln/Lrn42vK4sT5cWWch4eZpKOIyBkKX2E/XAbl5tcH5y+PEZHBJnZ3AUvZAAK+Fnoxy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054196; c=relaxed/simple;
	bh=NGlFEwneXtdHCSd6YUaSS9Rs+Ie1kHnFGRiAH9QblTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnm+dC0k8AuMo/cdKemXoKZTQsCBsQDFSaFo6ARn3GYy+hczfRES0j5Nz8LvO75FFXfDYckytnmLZS7ZtG8EUpkBjWeyeJxslZQCHyVul28ImnkukJs0mPWMiH598lVtm28dYboUvz3y/Gv7yHa0eQsdgt1Beq2edsXTbllAeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlvSAj0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727054193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGlFEwneXtdHCSd6YUaSS9Rs+Ie1kHnFGRiAH9QblTQ=;
	b=HlvSAj0lNISkkNEVtbE/zcqaU4cPW3zClfcSOzxqrJ3crTLf/hfBlThSv/R2EIsr7kP7A9
	h6Wlk/bpSgAi3Kf+S6YG1OdQZSJBo6RPO7haLN0vlCBwfQDi7f6/lyxIwjh9YIofZwmAWM
	KEy06WUZJhDQGgx1dQvPMGG8gj/n5e8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-If0y3hBfP_SaltKZKb6Bjw-1; Sun, 22 Sep 2024 21:16:32 -0400
X-MC-Unique: If0y3hBfP_SaltKZKb6Bjw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8d13a9cc2cso283924566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 18:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727054191; x=1727658991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGlFEwneXtdHCSd6YUaSS9Rs+Ie1kHnFGRiAH9QblTQ=;
        b=dDsEWyjJDM4s4cXYLb0En+lqcyYRSe5UbPGgFk4ZuzwvRkeGrRLCt9+DQTRnEOMz5x
         bf/eetTlCj3D2/kPlOc5iUMLX51P2BN/HutdY+J1jflQJjdLPBq2pdY2IvQybv3X+QlK
         /7dTn/5PfLoS9eeJKZIr+SNcaniylcT+q4Agh9bRyzQgn/Xk91I8ZtDQ8+ijkkQhzxqo
         kxTHkCbUcnTIA0FUmoUVWtELn9DbRVr6vFfLcSGfhbhgg6+ExGC3FDZGwMGW1RDM1e5o
         TeNXKOMhtwlLf0dr91rmiOMomUfI9uGpPFgwlDgEKzffyuOMIRG3zhnTB16rgTx2GBuE
         GU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTU79vm0SRUR3xdbCa0CFPkFQBq4Yc+Xmoly9DUfQfNcc5qAnPnBMfL/vCZFk7ShFOABnhVRdU5rH6/Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEc1V4gQVPwLxdkyTQ120h4kiqKW+S8vNXWWrARuF8Za2EjYj
	0TJjEqv5t8jI57BvnIQ+ZiW/+fE5FTNwbPRiKw8xb3zxmmmxnkc+jn9iFQxTla77ZZo1p3gCaxh
	3ID0vmCoYdWm0MGGGr4N7G4wC8lPo1cI9gfVxX4HTZrelDO0/IN8SUpBjyl83HpMYWB1nhazeJ9
	XfU/3XLR7zeD7UiYK9iDWsPEc0Syidj+OFIwaL
X-Received: by 2002:a17:907:3daa:b0:a8a:6e20:761e with SMTP id a640c23a62f3a-a90d512796cmr914370666b.48.1727054191251;
        Sun, 22 Sep 2024 18:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLLV6DDO/qImWlmUkG7cp+y/TF1dZ2NGr2SXwRJp/tFhd3JDdFBV4oXjYWMZYgf3yJhQ5jZKJEo1GY6mfRngM=
X-Received: by 2002:a17:907:3daa:b0:a8a:6e20:761e with SMTP id
 a640c23a62f3a-a90d512796cmr914369266b.48.1727054190879; Sun, 22 Sep 2024
 18:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
 <20240910044139-mutt-send-email-mst@kernel.org> <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
 <94c76200-05b2-4142-a637-bf2115827116@oracle.com> <CACGkMEvAR_2j=PdKZZyAZ1yK7H5OO+Ldc0Eygwyo8rMR=_uGBQ@mail.gmail.com>
In-Reply-To: <CACGkMEvAR_2j=PdKZZyAZ1yK7H5OO+Ldc0Eygwyo8rMR=_uGBQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 23 Sep 2024 09:15:53 +0800
Message-ID: <CACLfguWXFOJK=YGZ1=bKYWEKp5_=mk3wVKbq_LSAzMGu1vODkQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: Jason Wang <jasowang@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sept 2024 at 10:11, Jason Wang <jasowang@redhat.com> wrote:
>
>
>
> On Thu, Sep 12, 2024 at 12:17=E2=80=AFAM Mike Christie <michael.christie@=
oracle.com> wrote:
>>
>> On 9/10/24 10:45 PM, Jason Wang wrote:
>> >>> It depends on how we define "secure". There's plenty of users of
>> >>> kthread and if I was not wrong, mike may still need to fix some bugs=
.
>> >>>
>> >>
>> >> which bugs?
>> >
>> > https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracl=
e.com/T/
>>
>> The SIGKILL issue in that specific email is fixed. The patches are
>> merged upstream. I don't know of any other bugs like that (crashes,
>> hangs, etc).
>
>
> Ah, ok. Good to know that.
>
>>
>> There is the one we can't reproduce so are not sure if
>> it's the vhost changes.
>>
>>
>> There is the change in behavior type of bug we discussed in that
>> thread:
>>
>> https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.=
com/T/#m026f7dd96e064e3a604155e45e7ae9d5c949ae23
>
>
> Yes.
>
> Thanks
Thank you, Michael and Jason. I will continue to work on this
Thanks
cindy


