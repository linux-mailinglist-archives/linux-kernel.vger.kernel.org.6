Return-Path: <linux-kernel+bounces-555438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F86A5B74C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94478173150
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076181DF985;
	Tue, 11 Mar 2025 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7r49EIs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3E1E9B1A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664255; cv=none; b=hbwsqHtymK1T/sQfElrZgkIuuLOm27IYEyOTkfAwKoTd2FmHHSvwKNpS4CBY438/JPYsGPjAifKZOnJAv/KpcT02ILvXkFrhhd6rj/Urj1XDcyszLiqOuofbnkLUyi9MyBVSDCmDOl8I2jYkINXlKZ7hFRetdOBdCpig5oB17xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664255; c=relaxed/simple;
	bh=WJDiIpzPVyWLH5Cn8j/8u3aIFFtw49GPgJTMCyuAZFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/6hDgHdkRJP30MErHUm9uqC9y+oOiqp8s6Br5q+rH1G8FBl2+s7jAcWu0pg5jxkqMBmosmxW5NKExK84+sEgdyhvUypdYqOGr64c03VETCt40eXHJMxDdq49nVx2iAS3PcDr+GRLseH40oromTa5KOd67ThEgLuXujM9DvVECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7r49EIs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so68675ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741664253; x=1742269053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKKMXhARfXEwg2PwHrZN99nBi8+39p+oYTJh2YeoKoU=;
        b=R7r49EIsnN7h/+o3taKGdxwyS6LTzYjaMxZ6eza16XBSC7e6lyvhyA8SxT9yNJwZCL
         ftWf4Sl5oO02NYlDMk432YfL2hSTBPQg9mxtJIpy+La2kW2lWlCL8Et5hX9ZTbY5FbWn
         5Sq8E00Vxm/oi7Y1O2qGbbrOGWyJZ5WwnRcMrUPw4+qXnYmB5if25PpKz1Z+qDBRIX9Z
         N84QCsK+9ej17pCRz0y0IsncIfkw6T+yfgQBa+kwHPcSoWpYhtPOuItg38bzg4M0X/uW
         wN4SS73PPN1CbO+P86QekKiH32mdArq9zwiGjDt7sZoeLk97je+nUkNajlz2qVx/DqUG
         As8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741664253; x=1742269053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKKMXhARfXEwg2PwHrZN99nBi8+39p+oYTJh2YeoKoU=;
        b=sv6cndXa51Gfa95qHjKfqYp5mYPUTEyrM6ptqupC6eEj10rELuWB+xiVtF80PUACG2
         it+uN9dTf2FEvQ7iZSb8RQzL0Q9NEoYnPHETzBbfmUk6BqaHsQcKQsN5pQ0EUS/gN0qW
         041m0r/gPmlp2OwZyhuUBosJ7db6exkak00emSt7VnLQaTPk1Pva5ZCcPz7kV4t9YS7+
         Z3EhAYBqS1539QBR66ZEjY9RTmVMhwCdcV2SZBvmBjFS6CZ9zPPk9+DnoyI7tkqFP4nF
         46LUWEvU6QFkUOO2+r6CVZNEud5vATra/pftC/2zFjKKFvRt2n8xjRd2okqtq3/V51lp
         dkNw==
X-Forwarded-Encrypted: i=1; AJvYcCWrLQoAI38qKMicklHsQ3hoE996dHbacV81vlMG2jfn1vVOokpVc+d2f9aacxZqkvONmccTVNOS8wPYLQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Cm0ZuU02Op/YWFf85LhDZMx6UNrTf5j65CrB6eXVANZZV+yB
	jtTJWtM/J4G+4L3hyVcA4vJuPqVY/UaBvR4bupz1U1XgcCAC0N51oLxOqHq7gw==
X-Gm-Gg: ASbGnctRwxKF8ri27encEPS4a+yozMmMdaoXC+bp5qPjEfo2RoIhXOOTVaIaOFt3Vas
	lEeoTbOGGA6W+XkKbH5IqSyr6nS8ip1odFPPXP7M+N0vDywkLvFZ1XbdKFAO8snOnzJgsSND9jQ
	03AB3lX6zLkAj7OiTMDhDnhwJ2r0Uogy2eMCr87JOs+Yz25agDulhILnzVmeaQMsvyeRZOnekoh
	7oRcCoo1YoyglQVC11HIS+7s2O0boBnk6iXL9S7JMWC9tutnrG6gNaBZ4fb/pX2yClT18zNCeeN
	8Gy7sm9V1Hk5gADDntCzow9h8mMUjNYZGA0QgOlzldT84CDfxsqiJSxk2II0NejtBO+oJKgRFdJ
	vD/UyIbM=
X-Google-Smtp-Source: AGHT+IEK91Z6kXFaIWJCVbtXPxgiAIU5QooJrJa6uX0FbecTFo4b+EzP9+Bxt6J46OcmUjrvYOGJvg==
X-Received: by 2002:a17:902:ecc4:b0:224:a93:704d with SMTP id d9443c01a7336-22540e584dbmr6561245ad.2.1741664252755;
        Mon, 10 Mar 2025 20:37:32 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e789340sm10752115a91.26.2025.03.10.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:37:32 -0700 (PDT)
Date: Tue, 11 Mar 2025 03:37:27 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de,
	masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
	tweek@google.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	selinux@vger.kernel.org, hridya@google.com, smoreland@google.com,
	ynaffit@google.com, kernel-team@android.com
Subject: Re: [PATCH v16 3/3] binder: generic netlink binder_features flag
Message-ID: <Z8-v92gIPgrxWq1w@google.com>
References: <20250303200212.3294679-1-dualli@chromium.org>
 <20250303200212.3294679-4-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303200212.3294679-4-dualli@chromium.org>

On Mon, Mar 03, 2025 at 12:02:12PM -0800, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> Add a flag to binder_features to indicate that the generic netlink
> feature is available.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---

The implementation looks correct. However, the feature you are adding is
not "generic_netlink", maybe "transaction_report" or something similar?
Future features might use this same interface so lets avoid confusion.

Thanks,

