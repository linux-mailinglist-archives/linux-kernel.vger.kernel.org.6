Return-Path: <linux-kernel+bounces-532591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD535A44F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7566419C4363
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DD21322B;
	Tue, 25 Feb 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blpvUsDr"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5D21ABDF;
	Tue, 25 Feb 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521834; cv=none; b=Jg3LozgNUMt6NanT1m05kmpkqDj167oiEyr2LmS6B5Tvt3C/gH9onWHpDTiEParffZ/jLV6wyaSFFWAkrtvYcjU7rfpCrNYRfPjoRbgfm+g/rcoU7MjjoE7hme9T9P6BaL3zIF4dkuhh+2erxA1s6kDGqbOYU9UueCzsYfTsFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521834; c=relaxed/simple;
	bh=QP19tnSUO6+HLqxH1ELuRp+Rtpr531yPVfYEaoK/1/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1s1+6KUvsFAHCyr64EO67uYiiw74I7sPzBf0M3UfPGlpx317z+MSIM01Yb2IYHgvSnPB/+rA1lXiW2pAdgF87YvFCY0u/slLSFCJxIOoebmouJ/v1mDZOJ5WjkbjwAiu3nOqIGURscdq7d1f8jmzNhCIpb6NZzjQgs5R22t08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blpvUsDr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb7f539c35so1190632466b.1;
        Tue, 25 Feb 2025 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740521831; x=1741126631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH1ejT9qluyOxi6z4OMvRkQd0hvbyUhN+fXwbEGK+rc=;
        b=blpvUsDrPfR4zcqUpzXVcmyhfaclj7t9CFZEh/jnsaNML2YL3KeDqY6bl/ih7bCJQI
         Fne9peHH4Bn038+q/Qn4Z0fuNsBkXxQw/HUZGrREVHzt3Z5lDbKcv7XEVa0Az0huQAtp
         THUc02FN8xoGSDraD0ZwlSwFjS6i/KyXHRADqbrYRANp77OyEzo9J4SArNQGi9sp0yF1
         A1pgin8gWtlvXjX5SusdaB355EjlYWDlNfEMaTZqseIJ0BasFQvn0PeRXBELa8RmkOnb
         so8SUw3uedgJpCnAIU8mDVEID4X0wiY6yfqiWy5pnJZRWRgTo896N5/p8+1ATl8Nogao
         BlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521831; x=1741126631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fH1ejT9qluyOxi6z4OMvRkQd0hvbyUhN+fXwbEGK+rc=;
        b=AKYo9b7H9QyPH9/+FQYmtvgL4bRQpL2RChS1t2jGGS/C6nSDMU/RRcI0iGbQYXo2OX
         nhDb8Dh6GO6m5qxppW+G1LTkYs5dzS+Wn6kxoeYtJZxOvoed/6bJ3aayC0BFhQtFQXI4
         RaBPebSpCChbEVlF+y0dXlwgldnqOGl2RhANhJabkZifUYDJtJUa51PIN8gpQinWiQFI
         FMnCrwDC0Wape2DbuEugHZmYY9NEWlhjdvQGz3jDDM91+kZ1Pjfrpkydmy7omjhP9asX
         7L/GLfiqPCV6l++CSIO8WPBARuQvzGiPduCEntm8q1J26XkTkOV1qDWi8vi8LA7PSHDW
         AwSg==
X-Forwarded-Encrypted: i=1; AJvYcCX/YSmR0xlpIx9s09yRmHjQAwoNjxTLdU6b02MtaORhBflTp6TdPw/Kk99nxnjmFPsOEzMlLPTE2V2WB4I=@vger.kernel.org, AJvYcCXUXXzKN97xgFSJ6i1qGw05AyeFBI9qGKsyt1fYZ/uv+5bFmqEX07R03CobVtnVqaPY8T5Lnh27cvdf@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQJCqdruf7OkWvw9xAzWV1RqJyckDg2xT2yn0JWlynXuUho42
	Anre6BkNgun1PEq2m5TfT+Wi0jgRZ/dRwgyUWz0zzmTdcB47z3Cn
X-Gm-Gg: ASbGncsYATKuRELl/COHz3gJ+e4b6iuaIxJsNxYjUSpGI52ziKxBt0u2B/XxngvYDts
	lu3XL0Cgq3EmtNb2B1bHql3bS4ZfcOmHOhNwsD81FvnFxgDrv+c208cVjNRDNOUkjcleTKPA6Rq
	Ua2BUZJJ1LacxbSrZpxMmBiIjDWxkw0duFXxmrs5+efh5doi8gAdeYbtKDYhljjLkfTlWHf4GDI
	X4MMhH3s/jS6/u37WZh2aPPNmD3EmBKegTXgMC/MK0LvXen+M6tBLhaNjXjcOYsf6+3QrayYEtX
	iaVC1f/A96vRjG9Dqpcm2Wm5Plnw+3oqn6pO7Taq
X-Google-Smtp-Source: AGHT+IFv5xQtOyaT5z0hxjQvRhVdVKN5ONoFFGjZjoPiPJ0F+I3C6bLQSwC1YbZ4C+i0+9LQsT29ZA==
X-Received: by 2002:a17:907:728c:b0:ab7:d481:212e with SMTP id a640c23a62f3a-abed0c7a097mr495602666b.12.1740521830500;
        Tue, 25 Feb 2025 14:17:10 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b6a05sm212587966b.174.2025.02.25.14.17.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 14:17:10 -0800 (PST)
Date: Tue, 25 Feb 2025 23:17:05 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: xhci: Simplify moving HW Dequeue Pointer
 past cancelled TDs
Message-ID: <20250225231705.3fa7c8bd@foxbook>
In-Reply-To: <b82f9543-2730-48af-81e8-1612b0d30ed9@linux.intel.com>
References: <20250225125750.1b345e2c@foxbook>
	<20250225125939.7a248e38@foxbook>
	<b82f9543-2730-48af-81e8-1612b0d30ed9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 16:55:49 +0200, Mathias Nyman wrote:
> This new way relies on td_list being in sync and up to date.
> i.e. hardware dequeue can't be ahead of first TD in list.
> 
> One bad scenario could be something like:
> 
> class driver queues TD1
> class driver queues TD2
> Class driver cancels TD2, queue stop endpoint command
> (Class driver cancels TD1) (optional)
> 
> xHC hardware just completed TD1 and stop endpoint command at the same
> time, xHC hw may have advanced the hw dequeue to TD2, write event for
> stop endpoint command, and then write transfer event for TD1
> completion. (xHC hardware may do things in odd order)

I suppose this would be illegal; per 4.6.9 transfer events are posted
and EP Context updated before Stop EP cmd completion. HW Dequeue Ptr
is advanced on subseqent doorbell ring if the stopped TRB is complete.

But I can see how this could appear to work fine and then mysteriously
break on some weird buggy HC. I will abandon this patch for now.

> Now we detect that hw dequeue is in the cancelled TD2 but with TD1 is
> till in the td_list. This new solution would move dequeue back to TD1
> beginning, and process it again.


