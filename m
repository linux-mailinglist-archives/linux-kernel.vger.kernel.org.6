Return-Path: <linux-kernel+bounces-209172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AF902E38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A05A282068
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CEBBA42;
	Tue, 11 Jun 2024 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/yN6w78"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314C8488;
	Tue, 11 Jun 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071668; cv=none; b=FrdLUSXByIoF7mWrs/Zh5eoA/DDPGreAlVsK702J3xfTu3A438VkL9gAO8ICLq7ESlBPLPLM+Bc4pZQpUhysrGNdMp2yevrSezNNBBKZdLeUJ4dmYBl+CiDVLuwWhn/mqGmcg3VM1BlULJmtsPVABOEHGfQlGxZTw1tP4dJDZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071668; c=relaxed/simple;
	bh=t+FQJsYag++4WO2qxLXgPpQ0EMcj6jfCuoNIA7zG5a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sho0n4QNIgpcUqwcL5a0fpN1zmVNT3eK0AJxYf3cm5hSeaodlpv5lrPHSpAWYReqTgyKAEnzUZ3ileiWzLyoprFlP0XKeF9FUS6LlhgooY0LoKZ5DIA1cl19lhEZzBuhvL4Kx/HtYgLYrzzBpHGdososLRw+FHADvT7oBDFvK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/yN6w78; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b96a781b63so1817760eaf.1;
        Mon, 10 Jun 2024 19:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718071665; x=1718676465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7K602fz4gBHUWwZgz6PtHdWhG4F3fJUQgT9uMqHP2k=;
        b=M/yN6w78Uzs9Wzo3QV21NtxxdI1QUeYTn6RVAN/XpHKW6CwFUiHYzWLvlFj2Q+Yk52
         R8Rt5Dt6MjKyOYk/+36oQaPS5z+C4boBygL8zbRlDPTQA6ABpyVd9KXhsJ59jAjAc9Ip
         LzGiwu4ZC+Wyz0DOCMj/s51bjjfGGorfege8fJHt+CqqAUNM00HGxfISTswAlqPKBpIJ
         FtTirLOQZuJjYJA05GZ00ev3RRfsNNrWK6qk4J8Rt9KgyrKHPZpIkNkc1LPMHU50+yMi
         5r9/B+Kx14qzOzBmACCMbkcePLBgycdQMgtIOgME9voHpsxs7YbniGoz+5CLAPp96Om0
         V1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718071665; x=1718676465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7K602fz4gBHUWwZgz6PtHdWhG4F3fJUQgT9uMqHP2k=;
        b=dbXxF61RDS5cb+QbGXZJXEwLbgWKjeXEgpttHTtgADoap039VWv4RiXhp3SpECqx1P
         Lek7MQvx+RyFbn6j0LXUMKKBligAW24bfzLa+7P7t4Qbl2UgACL5CY1+mKZd9G8K3cxw
         hYzq21Om/FQ8Okd1YFOS05OzCWhsBhBLqVIfMOVt3aDXEt8TgzUio0HTkgeU1erZTQUV
         TzslK6TjV4FtVKMMrgy6+uokKLg+iBjtsk09WJV0JJdjc9OKA60po+8U7SSx4tBNEHS/
         THaF6mNZOHKk2puFltHCjz9+7CRjngsNsSCtMhstId2H1qTc5FpoJyknE9Zs5SxeJNs+
         zCfw==
X-Forwarded-Encrypted: i=1; AJvYcCVoeGjvMQQMVa3QHyaXwUZzd5sIoHugfmYxnvtFVoPBzAfOoy0RsnQa8sg5hoLUiXiT/EaQM11h1WSgn/0BfMFSmvNvxVKS7flDJwJBcQHrourykTvsGg+RVmxgMGJhQpYM3X15BMrx
X-Gm-Message-State: AOJu0Yyr7kpj5MXOyjMs5v8lLTsyI5TYfCrlziJcBwpr43zggpMLsDU4
	pCcFE615DvBFBXAoKisZi6U6QlU9rm+Dcrj5eDgUf7j+Reu65fHr6wJ1cvKu8IkebEdc2viz53z
	wiEPfjS+CuAc21g7op/UG0WAGXD8=
X-Google-Smtp-Source: AGHT+IF5NJP+cpN1QZ14dVDvRLKhqj/JIMm3OyP45URA0uC4Hs/4MNcrZV5+u6AtOEjVEtzm+FJweysb15RclHZy/3E=
X-Received: by 2002:a05:6820:1c9f:b0:5ba:e5c3:4fa6 with SMTP id
 006d021491bc7-5bae5c35072mr6628691eaf.6.1718071665549; Mon, 10 Jun 2024
 19:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610003520.33839-1-dzm91@hust.edu.cn> <202406100911.QBMVtIpz-lkp@intel.com>
In-Reply-To: <202406100911.QBMVtIpz-lkp@intel.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 11 Jun 2024 10:07:19 +0800
Message-ID: <CAD-N9QXgU7_iCLmH5z0e78ydCkwgWiz2Mti6zDqQp9jnExiVAw@mail.gmail.com>
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of security-bugs
To: kernel test robot <lkp@intel.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Hu Haowen <2023002089@link.tyut.edu.cn>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, oe-kbuild-all@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:07=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Dongliang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on lwn/docs-next]
> [also build test WARNING on linus/master v6.10-rc3 next-20240607]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Dongliang-Mu/docs-=
zh_CN-update-the-translation-of-security-bugs/20240610-083729
> base:   git://git.lwn.net/linux.git docs-next
> patch link:    https://lore.kernel.org/r/20240610003520.33839-1-dzm91%40h=
ust.edu.cn
> patch subject: [PATCH v2] docs/zh_CN: update the translation of security-=
bugs
> reproduce: (https://download.01.org/0day-ci/archive/20240610/202406100911=
.QBMVtIpz-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406100911.QBMVtIpz-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../=
../networking/netlink_spec/rt_link>`
>    Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../ne=
tworking/netlink_spec/tc>`
>    Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../ne=
tworking/netlink_spec/tc>`
>    Warning: Documentation/devicetree/bindings/power/wakeup-source.txt ref=
erences a file that doesn't exist: Documentation/devicetree/bindings/input/=
qcom,pm8xxx-keypad.txt
>    Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm57=
03-regulator.yaml references a file that doesn't exist: Documentation/devic=
etree/bindings/mfd/siliconmitus,sm5703.yaml
> >> Warning: Documentation/translations/zh_TW/admin-guide/reporting-issues=
.rst references a file that doesn't exist: Documentation/translations/zh_CN=
/admin-guide/security-bugs.rst
> >> Warning: Documentation/translations/zh_TW/admin-guide/reporting-issues=
.rst references a file that doesn't exist: Documentation/translations/zh_CN=
/admin-guide/security-bugs.rst
> >> Warning: Documentation/translations/zh_TW/process/submitting-patches.r=
st references a file that doesn't exist: Documentation/translations/zh_CN/a=
dmin-guide/security-bugs.rst

Thanks for the report. I've sent a v3 patch with this issue fixed.

>    Warning: Documentation/userspace-api/netlink/index.rst references a fi=
le that doesn't exist: Documentation/networking/netlink_spec/index.rst
>    Warning: Documentation/userspace-api/netlink/specs.rst references a fi=
le that doesn't exist: Documentation/networking/netlink_spec/index.rst
>    Warning: MAINTAINERS references a file that doesn't exist: Documentati=
on/devicetree/bindings/reserved-memory/qcom
>    Warning: MAINTAINERS references a file that doesn't exist: Documentati=
on/devicetree/bindings/display/exynos/
>    Using alabaster theme
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

