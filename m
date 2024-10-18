Return-Path: <linux-kernel+bounces-372081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC4B9A4443
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D3A1C21794
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1052038B6;
	Fri, 18 Oct 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eb91RbST"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185C1FF61F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271046; cv=none; b=n8/3bgplS1uYGvlaJ0S4auQF4XGEk17f87ty9gjAS28Yg/NtMjMjvCy/YoYR0BAo+9YHqmibClOKh5QpNw4etfANroS66OxYLCf0+XMn8tASSnPDPTXkO9XPjaHetpdo6nKjuQpm9TdJOu5ILuNUOBIdhBFucH3h5m9NLaRTgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271046; c=relaxed/simple;
	bh=wbnIyKNtAOw4mHiY3Yn6y2dFUFqcs9budHj7TLC8Uqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTDO/SjxEBfSl0azdL3ajzURhSNhV58h0/cH/yVVhHHiSd41i8DDiPEubyQvxrWMXOiyTF3/DlXLg4qrkJbIT5jQaVEuoxgkpY1++79RzlBvVRjM22Y1Zr5RVpPaREqz0rC3RJfzNJEnmXMi2UG0Hw84jvTC1ni4Iy8eDgiwtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eb91RbST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729271043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbnIyKNtAOw4mHiY3Yn6y2dFUFqcs9budHj7TLC8Uqg=;
	b=Eb91RbSTTaeXjr7gBGSZSxKeOmRRCWKySFHz16dWskPOjXlPwkn+wBuLCSO3/eS6YLfA2T
	gdhi1lc8dSdM/Pq5Jrqbx+r/zNZakwGFs9QZPwsG8YMfyRNPDq6gIpkgLvA+6t6wyr8/sP
	7pLHghcx/65jF/Cc8UyBjDwg+tiyWBI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-w_tD7JfsP-KUC00tkd9XrQ-1; Fri, 18 Oct 2024 13:04:01 -0400
X-MC-Unique: w_tD7JfsP-KUC00tkd9XrQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a01cba9f7so144744466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271040; x=1729875840;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbnIyKNtAOw4mHiY3Yn6y2dFUFqcs9budHj7TLC8Uqg=;
        b=Au9HbtwlpOiR2NOsp3HA1Ayl9GgtiuhQEvV+FlIVn5e0HuIJZECkPgLy26Qz3oFeRu
         HrSdAX4Xk5IbrNcuEm+YUGjUa6RhDwBBjjxGmSDjpomQUIKWpHTQn1ZecbfIUySXxJYY
         dhT1GA7ACb37RZY5jEHrOL12zVSSx8HEYVWQSxmDxT09XVwOcRrH46gSOvnM3WIEaCmk
         FRFnJquFrIhQUvbF/oTycZ/xyr3puqQBO+2fqJobOkubpu5jbjmZ69aPBOe1kQlQCPKp
         3DGb85yXmZcQn5bME3Ct7Zsquhv10XgAx+w0HS0O6pp0SJ/73qDyOcUeoa1hQGIGuBT/
         zDEA==
X-Forwarded-Encrypted: i=1; AJvYcCW6DXgT1TuUJZY6tnRXAm2ERH6Pu4z3LSvGmdP0NOWQS5q0cE4qlpG1/+9F3GVvP/U7TjGQX15X5Z+jujk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUSNDmSSvAoRNCkjm7ogfb6hVwqxi8HW1mqyXuNfVqvFYofAV
	Cyi3q6wWl/E19PGo/DieB0zA1lSNwV0rypfE5BkoLFUSE/ayPNRnArfkb39ykF0WW2P+olBNL15
	Ff7fo6TMyzCeJZwuSDKSFzYYdQwkrnTmaQnbwq+119rm2RJ4R01bVueN4Mkuqaw==
X-Received: by 2002:a17:907:5011:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-a9a69ca3722mr225740466b.60.1729271040500;
        Fri, 18 Oct 2024 10:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVj5EoY0vS3pib1TdR5a0IlbIf/nJZCR/F+kKmxn2eePos6zgRqr+6udjAkQbtN7lRT725ZQ==
X-Received: by 2002:a17:907:5011:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-a9a69ca3722mr225738166b.60.1729271040019;
        Fri, 18 Oct 2024 10:04:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc4a18sm117768966b.128.2024.10.18.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:03:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1519E160AD24; Fri, 18 Oct 2024 19:03:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Pedro Tammela
 <pctammela@mojatatu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: act_api: unexport tcf_action_dump_1()
In-Reply-To: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
References: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 18 Oct 2024 19:03:57 +0200
Message-ID: <877ca5xs02.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> This isn't used outside act_api.c, but is called by tcf_dump_walker()
> prior to its definition. So move it upwards and make it static.
>
> Simultaneously, reorder the variable declarations so that they follow
> the networking "reverse Christmas tree" coding style.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


