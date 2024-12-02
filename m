Return-Path: <linux-kernel+bounces-427947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019359E08A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9463174B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69F13F43A;
	Mon,  2 Dec 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6JW9WJa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BED13CA8D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155174; cv=none; b=cc3PgNXEkDIpGI2pbXwXuZ6f2L3bn0ORDV9tKrdOBgCZCVySifLPZtdDdX7vliJYlefRXLG5bdYUFcP0+P2QCM27fFa7T7z5eEJyf/mb6os5Og9SOD4wBy8xY0npyGgmeK5qt+UkCVktH+1hQLVbFmjYbIDzlyIfa8ypLkPvdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155174; c=relaxed/simple;
	bh=6+BSm5YefgojN/nFr2CcH89agNXx6NCUZ3QcJZ7fUdo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUdNorArxCpOIVBn8hEv50ZMsTfJq5r9XYWuPh2RkHOxdylvlNxRxJKMnobx8ZcmBL1SH51kWTaTP7yFZySl+RZimPA7XLVi/JTIZ35MemMOS/3hIxEy9hYTedAh9sk8QDgZRw6+riZgXdiMv5ua7LE3PL+s04iHagrFa8xiphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6JW9WJa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733155171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6+BSm5YefgojN/nFr2CcH89agNXx6NCUZ3QcJZ7fUdo=;
	b=X6JW9WJa6AIWCGSMLS0eXrbGbjuAFf3XI1yQKzpcGDFl6biECAVGTVwnkfQPLgGJnJd1wF
	KOfBvW6yIo4uNI2iRtAerBHbtsT8M2fZfCGM0Aaaye9XMnq1mLJBMVHT6Fyu85HAkWDrV7
	hXjZmXoNPkH29NHcedpx389jLCbxdWE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Xc2l8e4yON-FFQhe-8wpNQ-1; Mon, 02 Dec 2024 10:59:28 -0500
X-MC-Unique: Xc2l8e4yON-FFQhe-8wpNQ-1
X-Mimecast-MFC-AGG-ID: Xc2l8e4yON-FFQhe-8wpNQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e3cbf308so796091f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733155167; x=1733759967;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+BSm5YefgojN/nFr2CcH89agNXx6NCUZ3QcJZ7fUdo=;
        b=gAe0bJGNuWPkBp7HrCZUfd1qtGeQCvhkBqMHjatQa2GigEB19srVN0HT0Ty1HMPEm+
         0UaziOzxBUXXT8C4YlF7YP4kDyN7c9G5DAGyuvWrj0BZmtCUCJX1yr1d7npQM3rvFrpj
         6IGrShWk/9DMsjaYSBve7W3n6BRC0fWllSdN7TDmM2cA9A456JkhsvTyvH5AJshJhPjH
         9B5uiAu9YZk4IF3UwHugna6FoNRYcxQ7LL/aHDsFjQIwxjTq/pXuhI05BSP5oXVGy+/S
         I0ulLFBFJnMIJkwkPZm++NvdiT97sy9+jYjgiQJd3nm41toRBYHkWWBHeSZTBso9cJdL
         B7JA==
X-Forwarded-Encrypted: i=1; AJvYcCWI39jS4Bg0UQnEkKpV2srVUoKvA6fsU2bzO/Wxh6aWemNNryfLUz2Ie53ur5OkADRa7tD22gS9Sx6GtDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHR8j62tfZfHfo/XLceEbU7BvMa+Kt6phdt/5bVQLI7P7oQroA
	ngBMndzpEnJXDKKgz3DF6aSoSlZ3aDoFCAZAPKdOBfCQWX/6J8TTRDKr/60W98CLDFedIb8cc9h
	pLLRXFzVyc7RqasV2io1t5dSD0lj9h8oYMlXZJd4pWq7F9jjEwsLStAPwW+Nmpg==
X-Gm-Gg: ASbGncvnSnGvFyqM5oPfsrN7abeSXGDz7po2DTqHDSCoNbSIodyPJZDNCdcKRQuOorA
	gyehVHV1xZxBkf7hyOxkWOoYnjoz2ZkIGU1s9i0ucjZcQtXWNeJtp6II9PBpOcv4HiewgZz9jGs
	KUWhqZRZ+qcfNaErycE+siAiJ9h8CSEbTYQX+3utjEYe1HfLkMywE3jqLPKRbn624UBth7jGZzz
	maDt9Gw1ssWLrgIdKxHpAMY3a0LE9JmXRtFDGpuOoFSUQz/tqUkESsAiHJri+3AY7Jp8NSCxuxh
X-Received: by 2002:a05:6000:1567:b0:385:f7a3:fed1 with SMTP id ffacd0b85a97d-385f7a40276mr2928925f8f.44.1733155167494;
        Mon, 02 Dec 2024 07:59:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8UVKO9PcvF2ItclPK8D+k/oONAjmWSeZGRBQuCT89xmSUAtYNnyZI8KKOgZ+U5/5c9KBsQQ==
X-Received: by 2002:a05:6000:1567:b0:385:f7a3:fed1 with SMTP id ffacd0b85a97d-385f7a40276mr2928887f8f.44.1733155167045;
        Mon, 02 Dec 2024 07:59:27 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a5d56da3sm139061505e9.0.2024.12.02.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:59:26 -0800 (PST)
Message-ID: <36f3b1a59604394d861ad89230a3d56231d2cae4.camel@redhat.com>
Subject: Re: [PATCH 1/2] sched: Optimise task_mm_cid_work duration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Dec 2024 16:59:24 +0100
In-Reply-To: <21a18b1c-b5ae-410c-8d1f-3b63358b0e61@efficios.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
	 <20241202140735.56368-2-gmonaco@redhat.com>
	 <c9a39d2e-6829-4bc5-b560-347ee79ff2e8@efficios.com>
	 <6b7b30528893b091b21a06ead610709219cd9ba0.camel@redhat.com>
	 <21a18b1c-b5ae-410c-8d1f-3b63358b0e61@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Mon, 2024-12-02 at 10:01 -0500, Mathieu Desnoyers wrote:
>=20
> mm_cpus_allowed can be updated dynamically by setting cpu affinity
> and changing the cpusets. If we change the iteration from each
> possible
> cpus to allowed cpus, then we need to adapt the allowed cpus updates
> with the associated updates to the mm_cid as well. This is adding
> complexity.
>=20
> I understand that you wish to offload this task_work to a non-
> isolated
> CPU (non-RT). If you do so, do you really care about the duration of
> task_mm_cid_work enough to justify the added complexity to the
> cpu affinity/cpusets updates ?
>=20

Well, no we don't really care at this point.. If it isn't a quick win
I'd say I can simply remove it from the patchset, for the current use
case it doesn't really matter.

Thanks for the analysis.
Gabriele


