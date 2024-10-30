Return-Path: <linux-kernel+bounces-388407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893339B5F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E2E1F21D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7F1E261A;
	Wed, 30 Oct 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMwCSgi1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB801E25F0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281831; cv=none; b=l8/TujD7quVvxio2/aQbAPYwUJChWllETzjIwiJtmWKfTe1I/OdUC/GZGmribk9/AbnHYSnbUk6UMts4q7XVoSrWRhW7mMxtT4IJx/68zNNRojAvrbilnBIKHK7qIegzOtCDvaPb129h5wpwbYZrPWFRpzGPqUyr734hzt4CoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281831; c=relaxed/simple;
	bh=yw+qgrswFYZZEPGEhoCezC7p6EMLBW9w0hRwCKfLPyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ1VDlXg8BcFcIWqRmN6pAvyOBUIcPl6PcPS4uxQLQf/9NBLjiJxmLN+YQ0wiXrciJ8mR2Om2T1oZ6TDadC1idZYSTU9vGehpxwqRXnpGYHqW4hBofWuMaviH7AGF+/OO1Xja/9V9rVuOQmshrY0Eu//Qly/ybNWX1PatmbLO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMwCSgi1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730281828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yw+qgrswFYZZEPGEhoCezC7p6EMLBW9w0hRwCKfLPyY=;
	b=NMwCSgi1sqkQrkhmeREPZo2Mt9DY8jDLW8o/lLYM4QrcGVM1mjqbgdOyo09PZfQe+UGXHN
	7GbkDbQySFpdoCIFtaRwAbAWL3PJcKeBXkItUcdIk4XtG8n28E+TV7UBxwe+oFtDPv7LNf
	wZbRC9uSt7VF9YvP9VOfDrQW0MBRDT8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Ch3HJABzPnmN4M7bbjnFpw-1; Wed, 30 Oct 2024 05:50:27 -0400
X-MC-Unique: Ch3HJABzPnmN4M7bbjnFpw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84feb9e9a14so1554433241.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281827; x=1730886627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yw+qgrswFYZZEPGEhoCezC7p6EMLBW9w0hRwCKfLPyY=;
        b=ii8dBY4qOIdgm4RdICop/C86dRvVh7cqEcHRUILXmQENyPLDhyrLfB2luobhigKM/3
         zOgxrS5KV9/TIF+Ckb5i4C96rr5TwAQ4yPOeFJvvMDq0yyzxSisBY42165kcW0YNyHaQ
         rNfNp/lbrn61S9u7zb7E6cBau9uihVl45hDkLrg8Z0oFqb4sVEQTFFPgDRxlszj77hNz
         JK4xwmv597Pg9iKbpOHmb75tcdzf1sJDIL5lbR7laqKfDKW9ufexKWn9/WE/FyY4zxHZ
         B6N/kG5rgxnno9lZO8sqzTHdzYuV9SD4gqPXEN59SSYYdEKesPKzDEeRsftAnMpU/no2
         8eqA==
X-Forwarded-Encrypted: i=1; AJvYcCVEtFO9QEA/ePxBftF8GkCS0CKBCvZ8OJwoDKW9zw/zzuQ2npECLpLkcHVj0KMnIYjR16zm1RsAQzd0A6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2bpgW4n1B9tVYADzDlT3/DC8+w31iuI2Wsl9/xoIi/1ZoZfW
	LG5PC8WbBYwwUgm4iIdGT1MO/odl0pEoHOOOHmW45E5I8YUcjsggW04kWLd1ulsNRhkYvk8oCxN
	Z7K3OQmBjreLtVsF5dABN4v/UVlWm/RfhlaqoRzvVuZr3vd38PSyDS613HqgUjCSWqUrjFPZJr3
	lAF96h9LACLqo9eTJPYxnFNKAMaLe3c7VBbG50
X-Received: by 2002:a05:6102:b12:b0:4a5:b7fc:7a40 with SMTP id ada2fe7eead31-4a8cfd4de6emr12961414137.19.1730281826760;
        Wed, 30 Oct 2024 02:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeJJ1xQxqX4HN4aM/wTAl2EKCwNKfmwOih4Ww8Rq4eXGBxq6k2he5HPduCvc1UrN8NKknkLV3oaMtdiixtCHE=
X-Received: by 2002:a05:6102:b12:b0:4a5:b7fc:7a40 with SMTP id
 ada2fe7eead31-4a8cfd4de6emr12961404137.19.1730281826407; Wed, 30 Oct 2024
 02:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025003722.3630252-1-ming.lei@redhat.com> <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation> <ZyHchfaUe2cEzFMm@fedora> <ZyHzb8ExdDG4b8lo@ly-workstation>
In-Reply-To: <ZyHzb8ExdDG4b8lo@ly-workstation>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 30 Oct 2024 17:50:15 +0800
Message-ID: <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, yi1.lai@intel.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:51=E2=80=AFPM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> On Wed, Oct 30, 2024 at 03:13:09PM +0800, Ming Lei wrote:
> > On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
...
> >
> > It should be addressed by the following patch:
> >
> > https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/
> >
>
> I have applied proposed fix patch on top of next-20241029. Issue can
> still be reproduced.
>
> It seems the dependency chain is different from Marek's log and mine.

Can you post the new log since q->q_usage_counter(io)->fs_reclaim from
blk_mq_init_sched is cut down by the patch?

Thanks,
Ming


