Return-Path: <linux-kernel+bounces-358234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943DC997BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B664E1C221B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4719D89B;
	Thu, 10 Oct 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSMiD/uE"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7237E199FDC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534346; cv=none; b=n6qzUVVDq9mSUjMmKgUem1gn6urM7rrI5nlrF2xzV9rP1Cc9NCH1rX/+rRJak0vO7/TMzipH3dadQDFoonrTpDSVHbmWnRG1EYZ5Uj59lIXGyGgl9IUJUrMHy/2fG3exK6aueL8SN5L/sWORN0bE5SVhzwigyZ3axwHJohAGYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534346; c=relaxed/simple;
	bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwLIagFbUe1sUNttud2eez1bK1gK5NGno9uTv68jcn26mSsWfq/+K6vPmy6wcJQJ+PN3pRfpexkjE12DtIkOq7dc2mT4pK7OAs0Rt1NWsWK4j9be3+F1CRRQzi9SAPz+hygjmCtqDixial3HwvCIW8F2z3vIAqL45Q+mJlC1PFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSMiD/uE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99791e4defso36511166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728534343; x=1729139143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=KSMiD/uEaRT4o0X2yCuKbsPvE5jolm/KfNmTKqiottd06Q3lHXeEgHbjIjDili3DTh
         C+cryc862veQackWPcDwIO4z1mvMwXqsh+VSJAugO9apJkpk6Yd9eF66H0MVmj44QBqr
         n2awzu4IJ41e4b01smEo+20MsnM9o1ZlaHfItSqpqsOGGy4OpU62bkDCgeoDJBOUvI/f
         pGTcU5LJRaepf3TXJQLZrP2l7CtzEZE/1DH6x6fyGquv402JyoMJ77ca0xzTTauNrQvi
         KGGOyLcrkmfL7hhrhTntvWwkwmYje4LA9TQecxI6THPE5Lw5xIOVLcqUYV3lI4l0J8TA
         tymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534343; x=1729139143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=M2fYdf1m+7Fk1gqRhF2TrNz4ZeduuqjCkCQqZemIkN0Lb93YtH39lA4X2xi7KOVBxN
         eR7PIQ5XCAyZy2pSjSiz3Qc0xUQ8GFBtGOjwN6JHiJDwd3Wn0+tzQOhiTspjWqYz/DNG
         u3ND+NhZQFH9ZV1xwDb2ugGdbgBb3V/9xLxI/roVUsvnCSR65XkPRm0Ftwci1Ful9Ze4
         gy8E8NbcYX60xxFpZOWLexAJR3L6QyWQMNWj/RzAaSWO7N324s51c5bBTRp+TmxTqcPz
         eCYxLS3p1XbOGKc00DQ3JJ+ygxokuuFB16xcIByizOMA1ENnl2lU0NFDKfb/cavUfCU2
         rPOA==
X-Forwarded-Encrypted: i=1; AJvYcCVgk8DvQstVoqHhgvAgwvAyGCz/S51w/X12utqkTqTPrIXSMN/Rh6zFyzRirM/OFdXI5ihOyoQ2IwP6Q9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vyx6fJc/g7cr0T7GD1FRKB4nuQHf//JT43hobU27g6xweQ8d
	7ZLdJioFk0S1tIHpAfcZiawPuLSjK43JkMQAb9hHvs7PlDOjsG7GakXMFVTm/GSAk5sTUfRcA+k
	UNHyzvhum/5mBs8Jh0q0KTCC3h+h2Gm8KNlNl
X-Google-Smtp-Source: AGHT+IFz4pdgZupNhn7in9zPhzp+j8ykgz7dxdPdgdBGTBuyCZjJ2XDwrC9kDTGTqCNbuhaIvTnqfMsflbbfqtgcbxA=
X-Received: by 2002:a05:6402:5114:b0:5c8:8cf5:e97a with SMTP id
 4fb4d7f45d1cf-5c91d6507f5mr4628607a12.33.1728534342434; Wed, 09 Oct 2024
 21:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-8-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-8-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:25:31 +0200
Message-ID: <CANn89i+vXeaSWP3EVtBC0RgmvkDy67590k=bXPjHenoHwFM8aw@mail.gmail.com>
Subject: Re: [net-next v5 7/9] bnxt: Add support for persistent NAPI config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Use netif_napi_add_config to assign persistent per-NAPI config when
> initializing NAPIs.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

