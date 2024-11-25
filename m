Return-Path: <linux-kernel+bounces-420547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F99D7C36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273CCB22368
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDFE17AE1D;
	Mon, 25 Nov 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HplA8IFp"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90492143722
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521344; cv=none; b=jJs05e2fAoK4J1o6t2jx4p9yf+aGRPUfRZMUw5lakcf5uig4drvT7jZn8MtIyE294KbFp/sZR0HQ9UQfDCB2pwH+amT19PVi7BvI58Asj0woiwhkw87srRJcV7d7V0NPAb8pV7oAyvL66/aQ59PjId3rDi8BsJiSkwLvwhW/5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521344; c=relaxed/simple;
	bh=sY+E04yoWBzWsHdiLKrAoVxRmCb/INKPi2UtOEQXIUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQqbzA8wULaPx+U+QPKkPR55roSpuxBbYODTHTsVFfqM7zfLXL1swhY1sNTIkw6qEjIwTM9fqcbXNwwQnVeOhrhRRL8gewGtpcZmAzuUZnaT8qIjXaAHmGShAXpPJPbRkj948ukGh63blQMqntbqrCjxGzN7errFRXv1TcAfGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HplA8IFp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53ddeef9e4aso1907542e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732521341; x=1733126141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZIGo3yTlv6am7OV853ap+f/qjKN5h0CP3WCOH7VIhA=;
        b=HplA8IFp3d5A3hmPJApY6NcL9mQ6Ng8MRqaMrdMH2m3PxHAslD6kfMaiJKGPHZeoF/
         SNhf7XFFFyVzSxb+BWBsmlFOVvGKL5LkZII73Xi5kqWNic/ZZdoPbbhp+sp9Jix1lZe7
         xwu509oPCNF446NtyvOEHjg9wQ1hT9HOAFHT8Aw0872cgMR8hQyZbybzAIYFdJ9TDCxy
         /wjhqpVK+hpsmnBRwAOsyVhAi1O8mpHvxXeaBtepIaVBXg9mYDgAH3P0wszbV9VpabWv
         15LToW2qI9KgujZTKRA8tQcjaV8yAGrTba5h3X07MfwXLQ9TN9MxfeqGn+Yl50XpLgo8
         rUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732521341; x=1733126141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZIGo3yTlv6am7OV853ap+f/qjKN5h0CP3WCOH7VIhA=;
        b=HFBG00xQIJ0TPIihamb1GoCArwzW2rbJR/DbjKNqlfHIJe8JxJ+Ko7fmKV0x1ajLpd
         63Y4GpRx+HzV6GtlzBwtSYMPPyHTzXDBMMD5RP+tM6qbBC+tPD5ySJENZRUqYWm+FtmE
         EFVviRPMxOcGvUHuPwovQBzuOuFS8jo8RFR30IGJjmLaZSrYL6+ttoSqLW3IYlQ83vbZ
         3qyeR14EZERjyjOmeZ53BjIuniAtzezUWLw7sw/WESZH4yRRJvgXtVlSjZ4Dsk5Y39ox
         qfz1SMSe33b6k0/4bpoBoni1AyvVDrmSvrI4V99I0c+1iMlu1v91t40RWypzYXCAngvZ
         cy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWi/wRdoDbKkQYirnG2MONOudXts5sVw61UP1/6R7jDrWFSxUKlrgfpf8672bdQ1RnoBBIW99+suendFRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeaeNZo67x3ArxyAQDPQGR5ujv58d9WSogwD0G4dWKWjuy/91
	TTLzY0JR3UK2O35G6AILSDPSK/LwPrZABzLqRsiLB4W2TLY6u8Urphu3eSPQ29+RdceoIJrlCH+
	q4d120eFZmVUXmMj/8CprlZ+vAjI=
X-Gm-Gg: ASbGncvMkC0fEvQfLo2ol03ZFx+Wy/1+A03lI871x3vz2MRuN3u31YBOTHNLYGfFK51
	Xd/Xvssyv8R1vrVtJKyIXriHSvc+UyBY=
X-Google-Smtp-Source: AGHT+IEX2TQ1O3wTcFG51cUF7z9UVov8MJqQaloN7Rc+mJwK8eOPWnWbJfLX33PQhLuzvo0p7hG/6wBrOsprHcNtofM=
X-Received: by 2002:a05:6512:250d:b0:53d:de72:a185 with SMTP id
 2adb3069b0e04-53dde72a1cfmr2753944e87.5.1732521340396; Sun, 24 Nov 2024
 23:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732368538.git.chunguang.xu@shopee.com> <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
 <20241125072240.GB15647@lst.de>
In-Reply-To: <20241125072240.GB15647@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 25 Nov 2024 15:55:28 +0800
Message-ID: <CADtkEeegfVhbkA-nbaOaveqtvSpxKebB9OdaBvCsWtSFJ7P46A@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 23, 2024 at 09:37:38PM +0800, brookxu.cn wrote:
> > From: "Chunguang.xu" <chunguang.xu@shopee.com>
> >
> > As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should =
no
> > need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simpl=
e.
>
> Yes.  And this matches what RDMA is doing.  We really need to go
> back to the attempt to consolidaste this code..

Yes, I also think we can do it

> Reviewed-by: Christoph Hellwig <hch@lst.de>

