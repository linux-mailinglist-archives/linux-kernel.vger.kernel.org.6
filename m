Return-Path: <linux-kernel+bounces-195182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9788D8D4897
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC2C285B73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B95144D19;
	Thu, 30 May 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB16+TbA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ACB15251B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061610; cv=none; b=Dlcrqqnpv/qR43BlM0LXUwl9dfnUPKB0NndG5Mlun7fADjmyOwyy62hs0ea2ie2VWoXbMyBOvPKdocaASMGkGQWUCq9oLmL9RiRBIr6FzazFeen231toj5k/itqCoX+LuQW/G8CMZeUBIdhHtrO0Xnmg8pBqopPP6hlBoZKGgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061610; c=relaxed/simple;
	bh=y/hnVCREW7LkNbFm25HWl7V9zGZXksC5dSRCqQRerIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eg+fD4aTvjyzlU5tCmsOTOXEuyhH9aqVTefMrBRFNZ1A746jGz5MiVyI6frdeznm2SzwxLCDK8N1W/nI9FeV+73ydi8UFrMWmvg6TB9TplFrgR1pI5QtYYErZQHc7buBr8U6q5eKrpynuof439AXWdpEgVyfG+7tvbz+H7j5J4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dB16+TbA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717061608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUC3GiLS6AozngaUvzZHBJhHgqIjB6D128VJ0PlNNsQ=;
	b=dB16+TbAkRbYIR+DqyN8THZNaE+ZlW+17ogr/lDzj7DuC5gp3fa479K0tUBelndx0a/z/U
	j0BAfsmUJ0QfvZz3U+y9A+psiaQSgFcqxzTx+5RRr1JDoBVkbuncTznCfgoD19i1xR9ca3
	ZEDMi2t0IflKUItaANCcWNy7NNgHwsY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-5QTMNk4WO_iX2ttd6xwb-Q-1; Thu, 30 May 2024 05:33:26 -0400
X-MC-Unique: 5QTMNk4WO_iX2ttd6xwb-Q-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3747f78b7f0so788305ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061605; x=1717666405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUC3GiLS6AozngaUvzZHBJhHgqIjB6D128VJ0PlNNsQ=;
        b=l5CT/1+RUbYwvlNq40m7eUqxZBycjWreIyEFzTPN44F3BSA9R9cpaSuj3dvg0ImC0k
         dcXyL3164VZXYI7Wg9rNOBIJv2UaSN7qoj7ucIQST3fdEO1NzxFVCf/kKj8qiUxDJhkK
         Nqtw2on2PlIkRe3/SSZlcSbCeYgj6K51uiNY/qOjMDK2CXz7L0nv4mErxU9PqmJz/DzF
         AdhMic/8kxJnbEFV7LvwYKLECxQHuYgvlaOWUPYPDV9X1/fq9Eo+oI2ARlpwOFFDczph
         gLcm0FOvKmv8kXR1mAtasCz8vlsxU7zJtmuEA9aITHYX55qW8OUj7I4x+h8csiaRyudJ
         n48g==
X-Forwarded-Encrypted: i=1; AJvYcCVeUB4J/o7GvkUHD080I7RHD6M38nsURl4tZj6rHDAK+eczXuGRnE/8OB/mhN07BVT1PpF7NYfPYxx0QfRmbgWD84VHHwPfI5vyjFgA
X-Gm-Message-State: AOJu0YyYr3M9CU6FS801M+veUgvDIFv5BcbFF5v76uJxrelieGxshmgq
	s8sSlC/aN19LqHd5aHTMPdRXIBmjoBa2eUthIH3y4A3KNhKlxeka4jyIEBTebAFryxBIoY7lzLt
	425vJoxRXj9COFQj+PlwGwlczDcvStD/gHs0Dk7RYVVXNNF1fRnTpD+pYFX4eDenEVTljdlNs2y
	QYqxVvjh1AanVYV4ZTbY4XtyNM2x9rXLooDsKu
X-Received: by 2002:a05:6e02:2169:b0:36d:96ab:f4a with SMTP id e9e14a558f8ab-3747dfa63c3mr15236025ab.1.1717061605393;
        Thu, 30 May 2024 02:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07FZF6G9bCv3Ha1VyWeLp5vvYcR+lGN7y97uhWQYZdbUL/l423c7F4PKTtj8AWBCWH9ONcFWnUZ8v1FJ3LEw=
X-Received: by 2002:a05:6e02:2169:b0:36d:96ab:f4a with SMTP id
 e9e14a558f8ab-3747dfa63c3mr15235855ab.1.1717061605055; Thu, 30 May 2024
 02:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425100434.198925-1-coxu@redhat.com> <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
 <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv> <ZkwS3UNmjTkK2HeY@MiWiFi-R3L-srv>
In-Reply-To: <ZkwS3UNmjTkK2HeY@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 30 May 2024 17:33:43 +0800
Message-ID: <CALu+AoRZ0mQBL6pCsMxMck_j_tD9xGR2ubSa6tcy3pr6rfSf3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing LUKS
 volume keys
To: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 11:20, Baoquan He <bhe@redhat.com> wrote:
>
> On 05/21/24 at 09:43am, Coiby Xu wrote:
> > On Mon, May 20, 2024 at 02:18:09PM +0800, Baoquan He wrote:
> > > Please don't add dm-devel@redhat.com in the public list because it's a
> > > internal mailing list or aliase. And I got error when replying.
> >
> > Thanks for the reminder! Actually it's a public mailing list and you
> > can find all emails publicly listed on [1]. I did some research and it
> > seems we should email to dm-devel@lists.linux.dev instead. Quoting [2],
>
> I always got this when replying to your patch. Maybe you registered
> before.
>
> msmtp: recipient address dm-devel@redhat.com not accepted by the server
> msmtp: server message: 550 5.1.1 <dm-devel@redhat.com>: Recipient address rejected: User unknown in local
> recipient table

Hi Baoquan and Coiby,  lists on listman.redhat.com have all been
migrated somewhere else.  For dm-devel, according to MAINTAINERS it is
dm-devel@lists.linux.dev.   I think the old address should not be used
otherwise it is expected to see some errors.

>
>
> > > To post a message to all the list members (who were subscribed with
> > > mail delivery enabled as of 2023.10.20), send email to
> > > dm-devel@lists.linux.dev.  You can no longer subscribe to
> > > dm-devel@redhat.com, to subscribe to dm-devel@lists.linux.dev please
> > > send email to dm-devel+subscribe@lists.linux.dev.
> >
> > [1] https://lore.kernel.org/dm-devel/
> > [2] https://listman.redhat.com/mailman/listinfo/dm-devel
> >
> > --
> > Best regards,
> > Coiby
> >
>


