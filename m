Return-Path: <linux-kernel+bounces-210765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5D904870
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99962284F63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039E4A15;
	Wed, 12 Jun 2024 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7TYBj87"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00010F2;
	Wed, 12 Jun 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156065; cv=none; b=lJB/Ap/KYtjjp4xXgIUmChyOLwQVnXiwXGvqtUfCeURDn6X78rFi/ngLFlCNX5JgvOv80xaStKpqiUZakbD6sSkIuHSiAdq12teiEJu1lPNcinPOA4FHPXSQYNzJ7UYHgqUJM9OsCA3vQUwh7cs73DT/Ffvt3WgD3VDgA898gF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156065; c=relaxed/simple;
	bh=Zs3Gjos4LsBpSwXMnubnoIJmsGgPi02BZ5xWOBrRtKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LO9ANQTmKAGjc5Miq4RqQDFvCCBnhBulBq59LwcWS0MzTLmjMkCCNaWoEaHYjguXvMbPaTeO2qq16pocXfarbnz/LMvodTHc2JFy1Mc0d8FCXaTLbd6+Q6bMxNK3Aqik5DeCsoCO212nRJAiJN/PtpBANjd1s+N1ruhxgUxGGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7TYBj87; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7046e87e9afso1475673b3a.0;
        Tue, 11 Jun 2024 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718156063; x=1718760863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWRd6FFkLYS5WcN+M56v5OtkCFgkbR1vqPFfOWbUjbg=;
        b=F7TYBj87vj1JL9+ar9x0tc1HhrTjKGA6VTtZsDoVvUsoUqvWE/st1MChQHMMUsXviG
         gR18H7PQQ9T6hZa3ZVSGrd44qFEdbvau9W2vc3HKeOsPOlUcMeYuLDZDhsNokWyUSm/r
         2G/tlQEUUel/RxcIYVKWBohickRkidXnGzipuJ+DDvI3iaP8tRW8RKx6MO7XKobp6ray
         PBeGkcOoRYq99RuOdzcO7E7IOUlyuUiF2eWl5Cs8UkjmFMwHSictzOjeV3qGtVvjK5Rz
         1Wvn0f5QDNULQ+0/QhPmscf4FWTXJ544RlTVt4FDYh9VkC8LaFjYst1rSZZ6zjBTqLh9
         KN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718156063; x=1718760863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWRd6FFkLYS5WcN+M56v5OtkCFgkbR1vqPFfOWbUjbg=;
        b=tqCEaN5w3gjeBvL7WzCex25ZDbLsKjNuLeZ+MLC409TSyMmaN64XH11D2A94zV9m4h
         LSbfbzfPxsiby+XaMO6ygTM0bzhU6swOP2aGkuJSwg36+qvA8NLgLWMobS4xFAum+uua
         ALqKpYZrC3yjnhnvMsJ7YC7Sk1KkPWJFUpTRLFd6Nq6lwRLpCjRJ1gVNNTm0qMMzDRqJ
         YF57CiNGTr7/+xiWtWHxydVAyh75njzKcCJFacBC7BPuxxGytYT27crVBxsDSqfi/Xk0
         B59PW9KnprYy3rUn2TzsSO4dVOvaSmA9UCY/xOi3USzl3h3AUo7Uiqtacp5GvGCep4f1
         CJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGHvxB3KcbEvt3mnuSmKwXs+RMvrrmmvi6FeE9AHJle+MIY+YFO4cH/F/+LhT0c2umeQO3kxDJBwmKZ0TXY30XijKmxkiDobUh6QcqshbmdQzhEiWzDJ1INdkpyQTskUuTYEyyaLSI
X-Gm-Message-State: AOJu0YyCgfag1KjR9ptsP7C6t5AuIp2cEqPMGY4umYrlEyqxmzI5x58A
	fb9IUVhqzQtS8gJSPrUVoswTbmTo/9TOwsSz5A4z0DYLgvr/TqrMLJIn0w==
X-Google-Smtp-Source: AGHT+IG7efEIAlIisoV784XUCgcOg9PAp9r9MU0CzAeDRDFveS7hRtA8L9J6W9JJa5rW0EMiNDrFvA==
X-Received: by 2002:a05:6a00:1786:b0:705:b2c8:a23 with SMTP id d2e1a72fcca58-705bcdcc62bmr621989b3a.5.1718156063039;
        Tue, 11 Jun 2024 18:34:23 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70431c8cb72sm5629175b3a.145.2024.06.11.18.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 18:34:22 -0700 (PDT)
Message-ID: <6964e8bb-d2f1-4203-94db-857135cf7ecf@gmail.com>
Date: Wed, 12 Jun 2024 09:34:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts: add scripts/checktransupdate.py
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>, linux-kernel@vger.kernel.org
References: <20240611131723.53515-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240611131723.53515-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/24 9:17 PM, Dongliang Mu wrote:
> The checktransupdate.py script helps track the translation status of
> the documentation in different locales, e.g., zh_CN and verify if
> these documenation is up-to-date. More specially, it uses `git log`
> commit to find the latest english commit from the translation commit
> (order by author date) and the latest english commits from HEAD. If
> differences occur, report the file and commits that need to be updated.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> ---

Reviewed-by: Alex Shi <alexs@kernel.org>

> v1->v2: revise the output format of git commits
>         add some description and usage of this script
>  scripts/checktransupdate.py | 203 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100755 scripts/checktransupdate.py
> 
> diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
> new file mode 100755
> index 000000000000..5a0fc99e3f93
> --- /dev/null
> +++ b/scripts/checktransupdate.py
> @@ -0,0 +1,203 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +This script helps track the translation status of the documentation
> +in different locales, e.g., zh_CN. More specially, it uses `git log`
> +commit to find the latest english commit from the translation commit
> +(order by author date) and the latest english commits from HEAD. If
> +differences occur, report the file and commits that need to be updated.
> +
> +The usage is as follows:
> +- ./scripts/checktransupdate.py -l zh_CN
> +This will print all the files that need to be updated in the zh_CN locale.
> +- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> +This will only print the status of the specified file.
> +
> +The output is something like:
> +Documentation/translations/zh_CN/dev-tools/testing-overview.rst (1 commits)
> +commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
> +"""
> +
> +import os
> +from argparse import ArgumentParser, BooleanOptionalAction
> +from datetime import datetime
> +
> +flag_p_c = False
> +flag_p_uf = False
> +flag_debug = False
> +
> +
> +def dprint(*args, **kwargs):
> +    if flag_debug:
> +        print("[DEBUG] ", end="")
> +        print(*args, **kwargs)
> +
> +
> +def get_origin_path(file_path):
> +    paths = file_path.split("/")
> +    tidx = paths.index("translations")
> +    opaths = paths[:tidx]
> +    opaths += paths[tidx + 2 :]
> +    return "/".join(opaths)
> +
> +
> +def get_latest_commit_from(file_path, commit):
> +    command = "git log --pretty=format:%H%n%aD%n%cD%n%n%B {} -1 -- {}".format(
> +        commit, file_path
> +    )
> +    dprint(command)
> +    pipe = os.popen(command)
> +    result = pipe.read()
> +    result = result.split("\n")
> +    if len(result) <= 1:
> +        return None
> +
> +    dprint("Result: {}".format(result[0]))
> +
> +    return {
> +        "hash": result[0],
> +        "author_date": datetime.strptime(result[1], "%a, %d %b %Y %H:%M:%S %z"),
> +        "commit_date": datetime.strptime(result[2], "%a, %d %b %Y %H:%M:%S %z"),
> +        "message": result[4:],
> +    }
> +
> +
> +def get_origin_from_trans(origin_path, t_from_head):
> +    o_from_t = get_latest_commit_from(origin_path, t_from_head["hash"])
> +    while o_from_t is not None and o_from_t["author_date"] > t_from_head["author_date"]:
> +        o_from_t = get_latest_commit_from(origin_path, o_from_t["hash"] + "^")
> +    if o_from_t is not None:
> +        dprint("tracked origin commit id: {}".format(o_from_t["hash"]))
> +    return o_from_t
> +
> +
> +def get_commits_count_between(opath, commit1, commit2):
> +    command = "git log --pretty=format:%H {}...{} -- {}".format(commit1, commit2, opath)
> +    dprint(command)
> +    pipe = os.popen(command)
> +    result = pipe.read().split("\n")
> +    # filter out empty lines
> +    result = list(filter(lambda x: x != "", result))
> +    return result
> +
> +
> +def pretty_output(commit):
> +    command = "git log --pretty='format:%h (\"%s\")' -1 {}".format(commit)
> +    dprint(command)
> +    pipe = os.popen(command)
> +    return pipe.read()
> +
> +
> +def check_per_file(file_path):
> +    opath = get_origin_path(file_path)
> +
> +    if not os.path.isfile(opath):
> +        dprint("Error: Cannot find the origin path for {}".format(file_path))
> +        return
> +
> +    o_from_head = get_latest_commit_from(opath, "HEAD")
> +    t_from_head = get_latest_commit_from(file_path, "HEAD")
> +
> +    if o_from_head is None or t_from_head is None:
> +        print("Error: Cannot find the latest commit for {}".format(file_path))
> +        return
> +
> +    o_from_t = get_origin_from_trans(opath, t_from_head)
> +
> +    if o_from_t is None:
> +        print("Error: Cannot find the latest origin commit for {}".format(file_path))
> +        return
> +
> +    if o_from_head["hash"] == o_from_t["hash"]:
> +        if flag_p_uf:
> +            print("No update needed for {}".format(file_path))
> +        return
> +    else:
> +        print("{}".format(file_path), end="\t")
> +        commits = get_commits_count_between(
> +            opath, o_from_t["hash"], o_from_head["hash"]
> +        )
> +        print("({} commits)".format(len(commits)))
> +        if flag_p_c:
> +            for commit in commits:
> +                msg = pretty_output(commit)
> +                if "Merge tag" not in msg:
> +                    print("commit", msg)
> +
> +
> +def main():
> +    script_path = os.path.dirname(os.path.abspath(__file__))
> +    linux_path = os.path.join(script_path, "..")
> +
> +    parser = ArgumentParser(description="Check the translation update")
> +    parser.add_argument(
> +        "-l",
> +        "--locale",
> +        help="Locale to check when files are not specified",
> +    )
> +    parser.add_argument(
> +        "--print-commits",
> +        action=BooleanOptionalAction,
> +        default=True,
> +        help="Print commits between the origin and the translation",
> +    )
> +
> +    parser.add_argument(
> +        "--print-updated-files",
> +        action=BooleanOptionalAction,
> +        default=False,
> +        help="Print files that do no need to be updated",
> +    )
> +
> +    parser.add_argument(
> +        "--debug",
> +        action=BooleanOptionalAction,
> +        help="Print debug information",
> +        default=False,
> +    )
> +
> +    parser.add_argument(
> +        "files", nargs="*", help="Files to check, if not specified, check all files"
> +    )
> +    args = parser.parse_args()
> +
> +    global flag_p_c, flag_p_uf, flag_debug
> +    flag_p_c = args.print_commits
> +    flag_p_uf = args.print_updated_files
> +    flag_debug = args.debug
> +
> +    # get files related to linux path
> +    files = args.files
> +    if len(files) == 0:
> +        if args.locale is not None:
> +            files = (
> +                os.popen(
> +                    "find {}/Documentation/translations/{} -type f".format(
> +                        linux_path, args.locale
> +                    )
> +                )
> +                .read()
> +                .split("\n")
> +            )
> +        else:
> +            files = (
> +                os.popen(
> +                    "find {}/Documentation/translations -type f".format(linux_path)
> +                )
> +                .read()
> +                .split("\n")
> +            )
> +
> +    files = list(filter(lambda x: x != "", files))
> +    files = list(map(lambda x: os.path.relpath(os.path.abspath(x), linux_path), files))
> +
> +    # cd to linux root directory
> +    os.chdir(linux_path)
> +
> +    for file in files:
> +        check_per_file(file)
> +
> +
> +if __name__ == "__main__":
> +    main()

