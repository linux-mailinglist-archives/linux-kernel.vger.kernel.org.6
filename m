Return-Path: <linux-kernel+bounces-305915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC896364A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCA71C24215
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45CA1AED4A;
	Wed, 28 Aug 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="LCP5LS9h";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="T/lL4Rv/"
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9D146A63
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888460; cv=none; b=UZpMiH0Mb+YJ4nXpuNXLvlJxCB8QAi1ohCzMZpf9bBgGle6l3ZN2N4asRcHJMf7pdtrklwVDequ1PbcKvfDRhaTZ+tXhUhna9J/QLl8HhwC6fM1C+3AX6Fy8cJr70G12L0756LEza4V0E5CN35aDMKBp490Cp62FfQHZAsDUvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888460; c=relaxed/simple;
	bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMh2h1G5USDYJ2DVZGpMseXo+WjhxTlp6CJ5FvvA81gGSA3rmHF7NewHmYXoeJwfteG9yfLjaP5DpHlfajTHf9ws4+GjLuFYoLhpGbEleQBjND4uYZS+lEROXyvL96lAUjh29A9JAV/k0N5OlclF/6kqoPf+iMPRWMWUVrF47E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=LCP5LS9h; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=T/lL4Rv/; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888459; x=1756424459;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
  b=LCP5LS9h94fTEnUNKac/m0Oe6zQiw+wqEjYHPlIc9f2EIdCoLHzRfg2f
   s3T6jn4+yhWRRYKSB8+blhPMBzQ0lekYr5qqg7ptH0aumujoT8i1+M48k
   qOys0JP0f65VY/M4eIj8trjnQ+I+X0WEKMymLKiRiuO2ZKjbgAU2koe4n
   Av2rKQUgZvW+CtHNRr0YZZnNeSLSauAbr5Ntq1mSXW+Yc2CmAnH3OTCEL
   3u/mXntKObQ2PrO40HZA6MTHp6DyJjrLBRwRKciAsiQx9CWYx8n8NMfix
   tkMy1838t0fH+vaElx+e3gNNjdF8pRXU0m3x/CGBcIQfe1e+1cAPwM4Ka
   A==;
X-CSE-ConnectionGUID: jSNL1T68QbK5YwkCJQkTOA==
X-CSE-MsgGUID: i3W1+QimQNmGD6OQL94xDg==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:40:57 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d28a70743so793625ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888456; x=1725493256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
        b=T/lL4Rv/i5HK4hZatlEaK90AH9lPqZlVxtTUZM2lqWS8kUHyFm+v+7ji9GeiA6QFFk
         LnzSVfcpQZSD/E4999WznyI1XpsIDIUfeCIYfuodbRGfC48xwTG3t1clxS+KHY0vDn1A
         IidF7eVhPCdbi4WCjQdZ2VgG4yPu6XKzApU04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888456; x=1725493256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
        b=PQj0A2uPVozROFehAM2afkELdkhxZAbryk6CBGbE9k5GXZht/FZXSyO77/L8ROIF5a
         cdvLT7KGNQxTec5ap4oneCqkHFuDkNKwByIqTaodgrhJWJctZi7f0RCsV41d3pX2YgLa
         96vpv5CIC2W9f729JXKWVmKLfH6eMI6zS334KCoXjS9Sk4z6xAnG52fGoU374XO7q4PK
         Ojz52OG2ctSlYbmOBj65qcKypt+aOdec10yCN0HTkn3XOJh44OdEBdugqQHiJQ2cRA3F
         TD4BGkGwM5Y18jhXuOkdtEe6QiijXdpsvKR5gqjYer6yCRjdoodueUamIJf+2MnGZi1G
         gZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWlrjp5lw8tcXUHqglrb6W9KG1SzNpEwNvmEPxJY4ymmq7+eAXzrBqtoCOpisAFzjhMqPyy6vXjVxyqWDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7U3+/5VmxaeGqf45v6URd6QZTYrfH79sQ+VY8YPudwp/N/ay
	cBCix4xJgqjnzUtt77INkq5iIqAP6eLlfRJO6qmoBk56Xder71Ei10alDJV2jZrAgK2qxOn1wfh
	Jj3d6tWQRFCoCJTacEYIx0P+I+WYockhetXtzNd9d7h77aFYqUlq4zbwOnP3d/2ED7A/GOZE+Y5
	tOaJeOhViZ5bdQrYf4U6/Yi7/Z63d5PBeVsyMo9A==
X-Received: by 2002:a05:6e02:1848:b0:39e:6a2f:ad79 with SMTP id e9e14a558f8ab-39f38add897mr5489495ab.2.1724888456257;
        Wed, 28 Aug 2024 16:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHExE7N2HLmIBgUTC9d3TYDNHufWSKlu5VDT9xGH/MN29veCd9nNTH74lOUfkl8yPuD4ChlwNTSKCgbbCC8da4=
X-Received: by 2002:a05:6e02:1848:b0:39e:6a2f:ad79 with SMTP id
 e9e14a558f8ab-39f38add897mr5489385ab.2.1724888455901; Wed, 28 Aug 2024
 16:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4@eucas1p2.samsung.com>
 <CALAgD-4n=bgzbLyyw1Q3C=2aa=wh8FimDgS30ud_ay53hDgYBQ@mail.gmail.com> <20240827142749.ibj4fjdp6n7wvz2p@joelS2.panther.com>
In-Reply-To: <20240827142749.ibj4fjdp6n7wvz2p@joelS2.panther.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:40:45 -0700
Message-ID: <CALAgD-5SgEFKD36qtMxWoFci0pLiPxC6Y9Z6rumBr7bGO3x9fQ@mail.gmail.com>
Subject: Re: BUG: general protection fault in put_links
To: Joel Granados <j.granados@samsung.com>, Yu Hao <yhao016@ucr.edu>
Cc: mcgrof@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We use syzkaller to fuzz the linux kernel, and this bug is triggered
during fuzzing. However, unfortunately, syzkaller did not generate
reproducing source codes.

On Tue, Aug 27, 2024 at 12:50=E2=80=AFPM Joel Granados <j.granados@samsung.=
com> wrote:
>
> On Sat, Aug 24, 2024 at 10:04:54PM -0700, Xingyu Li wrote:
> > Hi,
> >
> > We found a bug in Linux 6.10. It is probably a null pointer reference b=
ug.
> > The reason is probably that before line 123 of
> > fs/proc/proc_sysctl.c(entry =3D &head->ctl_table[ctl_node -
> > head->node];), there is no null pointer check for `head`.
> > The bug report is as follow:
>
> Thx for the report. How did you trigger it. Do you have code that
> triggers it?
>
> Best
>
> --
>
> Joel Granados



--=20
Yours sincerely,
Xingyu

