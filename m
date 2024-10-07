Return-Path: <linux-kernel+bounces-353942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C399934E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1E21C23C11
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51E1DD550;
	Mon,  7 Oct 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/m9Kt19"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104918BBB2;
	Mon,  7 Oct 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321901; cv=none; b=umkaxQ1ij4cECZu5F5+fMZq9VXQzEziyj9RTm+1Rq2eA2pegD79juIDpU0X2Eu32eUwX6R9QEDlWhv7JIHbV/4XcN5YkiJeEmYjMJy5ngnOJCaSupMH09NW/r8qoZwEaHlcQWgVqXyVd/iovG3nvOcFek9I1ZgO8Fj4TmjWFnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321901; c=relaxed/simple;
	bh=gzZh6G6aaWM+kJ1QWVNs6ivj9ZQtZ6wJYdHddcihf/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDdXsNVOdlpFKfqYb/zFTJ1XQgCCRT5mZLkfj+91lG7R3DKrK5SyMZX3Zu+1ksbIMQnYwyAEnQ7MP6NCo9ORpwKZ1i9ZXUROuInuXS+uMD0dHFxYpnQIJzs9244kODWG5hJSveea3eMdLwMnxF+41qWo12cPZM4rdc72czStwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/m9Kt19; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b5affde14so35088025ad.3;
        Mon, 07 Oct 2024 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728321900; x=1728926700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzZh6G6aaWM+kJ1QWVNs6ivj9ZQtZ6wJYdHddcihf/Q=;
        b=I/m9Kt19ygjbmm6eXD7hkRpiaMX1jsx5R8kw7PACvhpEIR8EGbgAUznNp+lKNsJz6L
         PERu12X/aqNP1mr1N3PsdUjOo6X41XhSM1bCjCwR0MfkmO0PximBTPSjbHVdQZrm2QXq
         R/6K2VguR+mDgO5UQFpliAEZepFH4SZpdckgCzJsJMjfhZKo50KqDuZi+EndfbM9aiIw
         kVxLvmSxbxUQc4LtTIbQ1bQ7fTH9mMl0bgm1guOePxQ9h7Wb0nPZvs6PQgGEY6wHPwqr
         oK4A5SIvFFgcAkpFGu+YeZGE3AtAPtbRjotIjPvkl+U5oSlNMKOpYKDqE4M+E4vSHh6v
         0K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321900; x=1728926700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzZh6G6aaWM+kJ1QWVNs6ivj9ZQtZ6wJYdHddcihf/Q=;
        b=svnrB2q2O26Eopy4LDVplF4mtexT/IkLbGP415zyKP8Ionvz7urEpfhelJVlkj98Bd
         kHBf89ktHrcIktP2VwOKTzGSYwXGzc4eAcPdBenHVDwGRXCGlgiTGx9sKWdoce0hEetQ
         TH3Yp/sSEBvn7JEzqTPNPB7CtPa+UvbkJ7HEdsyKaQdgBPuOMzzRujahzeHKFYcdiD8b
         o/Kmg2X5gA/xsvpCC4neF0O9yIWklDUnIpI0mMnji3pZa5PuK8sdCWym4GUg6ZIEQykO
         als/lutqOEWUySOUjejAYKXostfTxMkbeL11Eo3V0IbMUC+bnsCAtkBMJmIBqGPVQsv5
         +0DA==
X-Forwarded-Encrypted: i=1; AJvYcCUye2ov2jjthlM+c98Uu/4SmZRC73vE/egGOVVHyBoTuZcSSoBUxdhdq86ib0Em4cDkN+yiV5In9Z2TQbr351lrDW6Q3Q==@vger.kernel.org, AJvYcCXLa9YuZNVJiZmIONhJMI+oknTMyEilTiRYKikw241VEn4OJBlqCwpHOLzErIl4D0Ug7xQy7N6tJlF/euU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BtBULcce1z33Gn8ERP2xDbtNmyptK0J0Iw5mDep5Xwnism0c
	Euvyk4FM0rmMSTMt8ARW+FfOdS3PHgK9wvPvomcCUXqmmUnji3eUnyzkxXTN
X-Google-Smtp-Source: AGHT+IFWi7UuQAkv4UcL3cUW3M+stG16cZo90q3iaHPYyo3TIS/MSMKgQCf+hv+m/yeoZbZVYNdTAw==
X-Received: by 2002:a17:90b:1645:b0:2e0:a9e8:b9c1 with SMTP id 98e67ed59e1d1-2e1e6296d3fmr13961014a91.22.1728321899942;
        Mon, 07 Oct 2024 10:24:59 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f919csm5667297a91.44.2024.10.07.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:24:59 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: w_armin@gmx.de
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	kuurtb@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] Dell AWCC platform_profile support
Date: Mon,  7 Oct 2024 14:24:56 -0300
Message-ID: <20241007172456.8590-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <771d20f1-ebf3-48d9-98ef-ec79b94c7949@gmx.de>
References: <771d20f1-ebf3-48d9-98ef-ec79b94c7949@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Mon, Oct 07, 2024 at 02:24:52PM +0200, Armin Wolf wrote:
> Hi,
>
> this WMI device is already handled by the alienware-wmi driver. Could you please integrate
> this functionality into this driver instead of creating a new one?
>
> Thanks,
> Armin Wolf

Hi,

Thank you for your feedback.

Although they the same name and same GUID, both interfaces are very
different. Alienware x15's WMAX method doesn't support any of the methods
listed on alienware-wmi driver and the de-compiled MOF file on [1] which is
an open source alternative to AWCC, makes me think this might be the case
for various other newer models (G, M, X Series).

Still I could implement it as a quirk of newer models. Would this be ok?

My only worry was that it could make alienware-wmi's logic overly complex
and cumbersome, as it would support two very different interfaces with the
same GUID.


Kurt

[1] https://github.com/AlexIII/tcc-g15/blob/master/WMI-AWCC-doc.md

